#define PERL_NO_GET_CONTEXT
#define NO_XSLOCKS
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define MAX(a,b) (((a)>(b))?(a):(b))
#define MIN(a,b) (((a)<(b))?(a):(b))

/* use the system malloc and free */
#undef malloc
#undef free

MODULE = Text::Levenshtein::XS    PACKAGE = Text::Levenshtein::XS

PROTOTYPES: ENABLE

int
xs_distance (arraySource, arrayTarget)
  AV *    arraySource
  AV *    arrayTarget
PPCODE:
    {
      dXSTARG;
      PUSHs(TARG);
      PUTBACK;
      {
          unsigned int i,j,edits,retval,lenSource,lenTarget;
          lenSource = av_len(arraySource)+1;
          lenTarget = av_len(arrayTarget)+1;

          if(lenSource > 0 && lenTarget > 0) {
              unsigned int * s  = malloc(sizeof(int) * (lenSource + 1));
              unsigned int * t  = malloc(sizeof(int) * (lenTarget + 1));
              unsigned int * v0 = malloc(sizeof(int) * (lenTarget + 1));
              unsigned int * v1 = malloc(sizeof(int) * (lenTarget + 1));
              SV * elem;

              for (i=0; i < (lenTarget + 1); i++) {
                  v0[i] = i;
              }

              for (i=0; i < lenSource; i++) {
                  elem = sv_2mortal(av_shift(arraySource));
                  s[i] = (int)SvIV((SV *)elem);

                  v1[0] = i + 1;

                  for (j = 0; j < lenTarget; j++) {
                      if(i == 0) {
                          elem = sv_2mortal(av_shift(arrayTarget));
                          t[j] = (int)SvIV((SV *)elem); 
                      }

                      edits = (s[i] == t[j]) ? 0 : 1;
                      v1[j + 1] = MIN(MIN(v1[j] + 1, v0[j + 1] + 1), v0[j] + edits);
                  }

                  for (j = 0; j < (lenTarget + 1); j++) {
                      v0[j] = v1[j];
                  }
              }

              retval = v1[lenTarget];
              free(s);
              free(t);
              free(v0);
              free(v1);
          }
          else {
              /* handle a blank string */
              retval = (lenSource>lenTarget) ? lenSource : lenTarget;
          }

          sv_setiv_mg(TARG, retval);
          return; /*we did a PUTBACK earlier, do not let xsubpp's PUTBACK run */
      }
  }