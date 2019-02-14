-- seems a bit buggy at times
-- sounds cool though

infiniteSession $ do
  let (beat, bar, beatDur, barDur, totalDur) = bpmToPhasors 100 4 4
  "s1_fm" ><> "d1_delay"
  "s2_fm" ><> "d1_delay"
  "s3_fm" ><> "d1_delay"
  "s4_fm" ><> "d1_delay"
  synth "s1_fm" $ do
    "amp" <>< let
      in 0.1
    "freq" <>< let
      in 300
    "ratio" <>< let
      in 3
    "index" <>< let
      in 300
    "pan" <>< let
      in 0
  synth "s2_fm" $ do
    let env = (envAD 0.01 0.2 2 2 $ realTime bar barDur 4)
    "amp" <>< let
      in 0.1 * env
    "freq" <>< let
      in 300 * semi 7
    "ratio" <>< let
      in 2.5
    "index" <>< let
      in 300 * env
    "pan" <>< let
      in 0
  synth "s3_fm" $ do
    let env = (envAD 0.01 0.4 2 2 $ realTime bar barDur 8)
    "amp" <>< let
      in 0.1 * env
    "freq" <>< let
      in 300 * (melody lydian $ randoms 16 (fromList [111, 1, 1, 111, 1, 2] $ slow 4 bar) $ slow 1 bar)
    "ratio" <>< let
      in 1
    "index" <>< let
      in 300 * env
    "pan" <>< let
      in 0
  synth "s4_fm" $ do
    let env = (envAD 0.01 0.4 2 2 $ realTime bar barDur 8)
    "amp" <>< let
      in slow 4 $ 0.5 * env
    "freq" <>< let
      in slow (fromList [8, 8, 80, 80, 8, 8, 80, 80] $ slow 2 bar) $ 300 * (melody lydian $ randoms 16 (fromList [111, 1, 1, 111, 1, 2] $ slow 4 bar) $ slow 1 bar)
    "ratio" <>< let
      in 1
    "index" <>< let
      in slow 4 $ 300 * env
    "pan" <>< let
      in 0
  synth "d1_delay" $ do
    "amp" <>< let
      in 0.5 * (sqr $ 2*pi*t*slow 4 bar) -- play with the slow amount, weird stuff
    "delayTime" <>< let
      in lerp 0.99 0.01 $ sin01 $ 2*pi*t*0.005
    "decayTime" <>< let
      in bar*(fromList [1, 1, 2, 1] $ slow 2 bar)
    "pan" <>< let
      in 0
