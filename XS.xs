
#define NO_XSLOCKS
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

MODULE = Text::Levenshtein::XS    PACKAGE = Text::Levenshtein::XS

PROTOTYPES: ENABLE

unsigned int
xs_distance (arraySource, arrayTarget, maxDistance)
  AV *    arraySource
  AV *    arrayTarget
  SV *    maxDistance  
CODE:
    {
        unsigned int i,j,edits,answer;
        unsigned int lenSource = av_len(arraySource)+1;
        unsigned int lenTarget = av_len(arrayTarget)+1;
        unsigned int md = (unsigned int)SvUV(maxDistance);

        if (lenSource > 0 && lenTarget > 0) {
            unsigned int * s;
            unsigned int * t;
            unsigned int * v0;
            unsigned int * v1;
            SV* elem;

            /* this block changes md such that it is always set to the */
            /* max possible distance it if it is set to unlimited (0)  */
            md = (md == 0) ? MAX(lenSource,lenTarget) : md;

            /* if string length difference > max_distance then return undef */
            if ((MAX(lenSource , lenTarget) - MIN(lenSource, lenTarget)) > md)
                XSRETURN_UNDEF;

            Newxz(s,  (lenSource + 1), unsigned int);
            Newxz(t,  (lenTarget + 1), unsigned int);
            Newxz(v0, (lenTarget + 1), unsigned int);
            Newxz(v1, (lenTarget + 1), unsigned int);

            /* init first distance row with worst-case distance values */
            for (i=0; i < (lenTarget + 1); i++) {
                v0[i] = i;
            }

            for (i=0; i < lenSource; i++) {
                elem = sv_2mortal(av_shift(arraySource));
                s[i] = (unsigned int)SvUV((SV *)elem);

                v1[0] = i + 1;

                for (j = 0; j < lenTarget; j++) {
                    if(i == 0) {
                        elem = sv_2mortal(av_shift(arrayTarget));
                        t[j] = (unsigned int)SvUV((SV *)elem); 
                    }

                    edits = (s[i] == t[j]) ? 0 : 1;
                    v1[j + 1] = MIN(MIN(v1[j] + 1, v0[j + 1] + 1), v0[j] + edits);
                    answer = v1[j + 1];

                    /* max distance exceeded */
                    if( answer > md )
                        XSRETURN_UNDEF;
                }

                /* copy current row to first row */
                for (j = 0; j < (lenTarget + 1); j++) {
                    v0[j] = v1[j];
                }
            }

            Safefree(s);
            Safefree(t);
            Safefree(v0);
            Safefree(v1);
            RETVAL = answer;
        }
        else {
            /* handle a blank string */
            RETVAL = (lenSource>lenTarget) ? lenSource : lenTarget;
            if( md != 0 && RETVAL > md )
                XSRETURN_UNDEF;
        }
    }
OUTPUT:
    RETVAL