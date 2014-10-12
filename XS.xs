
#define NO_XSLOCKS
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

MODULE = Text::Levenshtein::XS    PACKAGE = Text::Levenshtein::XS

PROTOTYPES: ENABLE

void *
xs_distance (arraySource, arrayTarget, maxDistance)
  AV *    arraySource
  AV *    arrayTarget
  SV *    maxDistance
PPCODE:
{
    unsigned int i,j,edits,answer;
    unsigned int lenSource = av_len(arraySource)+1;
    unsigned int lenTarget = av_len(arrayTarget)+1;
    unsigned int md = SvUV(maxDistance);

    if (lenSource > 0 && lenTarget > 0) {
        unsigned int * s;
        unsigned int * t;
        unsigned int * v0;
        unsigned int * v1;
        unsigned int diff = MAX(lenSource , lenTarget) - MIN(lenSource, lenTarget);
        SV* elem;

        /* this block changes md such that it is always set to the */
        /* max possible distance it if it is set to unlimited (0)  */
        md = (md == 0) ? MAX(lenSource,lenTarget) : md;
        /* if string length difference > max_distance then return undef */
        if (diff > md)
            XSRETURN_UNDEF;

        Newx(s,  (lenSource + 1), unsigned int); // source
        Newx(t,  (lenTarget + 1), unsigned int); // target
        Newx(v0, (lenTarget + 1), unsigned int); // vector 0
        Newx(v1, (lenTarget + 1), unsigned int); // vector 1

        /* init first distance row with worst-case distance values */
        for (i=0; i < (lenTarget + 1); i++) {
            v0[i] = i;
        }

        for (i=0; i < lenSource; i++) {
            elem = sv_2mortal(av_shift(arraySource));
            s[i] = SvUV((SV *)elem);

            v1[0] = i + 1;

            for (j = 0; j < lenTarget; j++) {
                if(i == 0) {
                    elem = sv_2mortal(av_shift(arrayTarget));
                    t[j] = SvUV((SV *)elem); 
                }

                v1[j + 1] = MIN(MIN(v1[j] + 1, v0[j + 1] + 1), (v0[j] + ((s[i] == t[j]) ? 0 : 1)));

                /* max distance exceeded */
                if( v1[0] == j && (v1[v1[0]]+1) > md )
                    XSRETURN_UNDEF;
            }

            /* copy v1 to v0 */
            if( i < lenSource || v1[lenTarget] > md ) {
                for (j = 0; j < (lenTarget + 1); j++) {
                    v0[j] = v1[j];
                }
            }
        }

        answer = v1[lenTarget];
        Safefree(s);
        Safefree(t);
        Safefree(v0);
        Safefree(v1);
    }
    else {
        /* handle a blank string */
        answer = MAX(lenSource, lenTarget);
        if( md != 0 && answer > md )
            XSRETURN_UNDEF;
    }

    /* TODO: return list of distances if passed a list */
    XPUSHs(sv_2mortal(newSViv(answer)));
} /* PPCODE */
