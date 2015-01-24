

Pdef(\a, Pspawn(Pbind(
	\pattern, Pseq([\ch1, \ch1, \ch2, \ch2, \ch3, \ch3, \ch4, \ch4], inf),
	\method, \seq
)));

Pdef(\low, Pbind(\octave, Prand([3, 3, 3, 3, 4, 5], inf)));


Pdef(\chords, Pbind(
	\chord, Pseq([
		(['e2', 'a2', 'd3', 'g3', 'b3', 'e4'].namemidi - 12).midicps
	], inf)
));



(
~chords = (
	\G: [3, 2, 0, 0, 0, 3],
	\B: [1, 1, 3, 3, 3, 1],
	\C: [0, 3, 2, 0, 1, 0],
	\A: [0, 0, 2, 2, 2, 0]
);

Pdef('come with me', Pbind(
	\ch, PdurStutter(16, Pseq([		\G, 	\G, 	\B, 	\B, 	\C, 	\C,		\A,		\A ], inf)),
	\dur, Pseq([	2,		2,		2,		2,		2,	 	2,		2,		2  ] * 20, inf),
	\emph, Pwalk([0, 1, 2, 3, 4, 5], 1, Prand([-1, 1], inf)).trace
));

~vel = 1;

Pdef('dbl', Pbind(
	\midinote, Pfunc({ |e| e.midinote ++ [e.midinote.choose + (e.dbloct * 12)]  })
));

Pdef('sea', Pbind(
	[\dur, \ch], PdurStutter(1, Pfunc({|e| [e.dur, e.ch] }) ),
	\retrig, Prand([16], inf),
	\dbloct, Prand([-5], inf),
	\dbloct, 0,
	\strum, Pfunc({ sin(thisThread.beats / 4) + 1 * 0.01 }) * 1,
	\legato, Pfunc({ |e| [1, 1, 1, 1, 1, 1].put(e.emph, 10) }) * 0.7,

	\vel, Pfunc({ ~vel }) * Prand([1, 0.5, 0.3, 0.2, 0.1], inf)
	* Pfunc({ |e| [1, 1, 1, 1, 1, 1].put(e.emph, 1) }) * 1.0,

	\crash, Prand([0.1, 0.1, 0.1, 0.6, 1], inf)
	* Pfunc({ |e| [1, 1, 1, 1, 1, 1].put(e.emph, 3.rand)  }) * 0.4,

	\midinote, (((['e2', 'a2', 'd3', 'g3', 'b3#', 'e4'].namemidi + [0, -12]))
	+ Pdict(~chords, Pkey(\ch), inf)),
));
)

Pdef(\out, Pdef('dbl') <> Pdef(\sea) <> Pdef('come with me')  <> Pdef(\velbase));
Pdef(\out).stop;

Pdef(\c1, Pbind(
	\dur, Pseq([2], inf),
	\strum, 0.05,
	\legato, 1.1,
	\ch, Pseq([
		\G,  // come with me,
		\B,  // my love
		\C,  // to the sea
		\A,  // the sea of love

		\G,  // i wanna
		\B,  //   tell you,
		\C,  // how
		\A,  //   much,
		\A,  // I love
		\G,  //   you

		\G,  // do you rememember
		\B,  // when we met
		\C,  // that's the day
		\A,  // i knew you were my pet

		\G,  // I wanna
		\B,  //   tell you
		\C,  // how
		\A,  //   much
		\A,  // i love
		\G,  //   you

		\G,  // come with me,
		\B,  // my love
		\C,  // to the sea
		\A,  // the sea of love

		\G,  // i wanna
		\B,  //   tell you,
		\C,  // how
		\A,  //   much,
		\A,  // I love
		\G,  //   you


	], inf),
//		+ [3, 2, 0, 0, 0, 3]  // G: i wanna
//		+ [1, 1, 3, 3, 3, 1]  // B: tell you
//		+ [0, 3, 2, 0, 1, 0]  // how
//		+ [0, 0, 2, 2, 2, 0]  // much
//		+ [0, 0, 2, 2, 2, 0]  // i
//		+ [3, 2, 0, 0, 0, 3]  // love you


	//\hertz, Ptrace(Pkey(\midinote).midicps.round(1))
));

Pdef(\c1).stop;


Pdef(\out, (Pdef(\low) <> Pdef(\crashenv) <> Pdef(\a) <> Pdef(\n1) <> Pdef(\velbase)).trace);
Pdef(\out, Ppar([
	Pdef(\n0) <> Pdef(\stutter1) <> Pdef(\velbase),
	Pdef(\crashenv) <> Pdef(\n1) <> Pdef(\velbase)
]));



\dur, Pfunc({ 0.1 + 0.1.rand }),
	\legato, 4,
	\degree, (4 - 24) + Prand([0, 0, 0, 8, 12, 17], inf)
));
)
