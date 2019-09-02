module demo::Test
import Prelude;

int aap(list[int] a) = x when int x<-a, int y<-tail(a), x<y;
default int aap() = 0;
 
 /* 
  bool inEventOfSpec(loc partOfEvent, Built b) = true
  when <loc ref, loc def> <- b.refs.eventRefs,
       contains(b.inlinedMod@\loc, ref),
       contains(def, partOfEvent);
default bool inEventOfSpec(loc partOfEvent, Built b) = false;
*/