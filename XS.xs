#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* use the system malloc, free, and alloca */
#undef malloc
#undef free
#undef alloca

MODULE = Text::Levenshtein::XS    PACKAGE = Text::Levenshtein::XS

PROTOTYPES: ENABLE

void
xs_distance (arraySource, arrayTarget)
  AV *    arraySource
  AV *    arrayTarget
PPCODE:
  {
  dXSTARG;
  PUSHs(TARG);
  PUTBACK;
  {
  unsigned int i,j,edits;
  unsigned int lenSource = av_len(arraySource)+2;
  unsigned int lenTarget = av_len(arrayTarget)+2;
  unsigned int retval; 

  if(lenSource > 1 && lenTarget > 1) {
    unsigned int srctgt_max = MAX(lenSource,lenTarget);
    {
    int * arrTarget = alloca(sizeof(int) * lenTarget );
    int * arrSource = alloca(sizeof(int) * lenSource );
    unsigned int *scores = malloc( (lenSource) * (lenTarget) * sizeof(unsigned int) );

    for (i=0; i < lenSource-1; i++) {
          SV* elem = sv_2mortal(av_shift(arraySource));
          arrSource[ i ] = (int)SvIV((SV *)elem);
          scores[i] = i;
    }
    for (i=0; i < lenTarget-1; i++) {
          SV* elem2 = sv_2mortal(av_shift(arrayTarget));
          arrTarget[ i ] = (int)SvIV((SV *)elem2);

          scores[i*lenSource] = i;
    }

    for (i=1; i < lenSource; i++) {
          for(j=1; j < lenTarget; j++) {
              if(arrSource[i-1] == arrTarget[j-1]) 
                 edits = 0;
              else
                 edits = 1;

              scores[j*lenSource+i] = MIN(scores[(j-1)*lenSource+i]+1, 
						MIN(scores[j*lenSource+i-1]+1, scores[(j-1)*lenSource+i-1]+edits)
					   );
          }
    }

    retval = scores[lenSource*lenTarget-1];
    free(scores);
    }
  }
  else {
    /* handle a blank string */
    retval = (lenSource>lenTarget)?--lenSource:--lenTarget;
  }
    sv_setiv_mg(TARG, retval);
    return; /*we did a PUTBACK earlier, do not let xsubpp's PUTBACK run */
  }
  }
