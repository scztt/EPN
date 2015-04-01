////////////////////////////////////////////////////////////
// BASE PATTERNS

(
Pdef(\epn_base, Pbind(
	\instrument, \epiano,
	\vel, Prand([0, 0.1, 0.2, 0.3, 0.3, 0.9], inf),
	\amp, 1,
	\scale, Scale.partch_o2
));

Pdef(\stutter1, Pbind(
	\dur, PdurStutter(Prand([1, 1, 1, 3, 6, 12], inf), Pkey(\dur))
));

Pdef(\n0, Pbind(
	\octave, 3,
	\degree, Ptrace(Pseq([ 0, 0, 0, 5, 0, Prand([8, 13]) ], inf))
));

Pdef(\n1, Pbind(
	\dur, 6,
	\octave, 4,
	\vel, 0.1,
	\amp, 0.2,
	\legato, 0.7,
	\degree, Pseq([ [-6, 8] ], inf)
));

Pdef(\p1, Pbind(
	\dur, Pseq([0.4, 0.4, 0.4, 4]),
	\rest, Pseq([1, 1, 1, Rest]),
	\degree, Pseq([Pkey(\degree), Pkey(\degree), Pkey(\degree), Rest])
));

Pdef(\n2, Pbind(
	\degree, Pseq([ [2, 6, 9], [2, 6, 12] ], inf);
));


Pdef(\ch1, Pbind(
	\dur, Pseq([1, 0.7, 0.7, 4]),
	\degree, Pseq([[1, 5, 10], [1, 5, 10], [0, 4, 6], \rest]),
	\rest, Pseq([1, 1, 1, \rest]),
	\legato, Pseq([4, 2.4, 10, 1])
));

Pdef(\ch2, Pbind(
	\dur, Pseq([0.6, 0.7, 1, 1, 4]),
	\legato, Pseq([1, 3.4, 3.8, 10, 1]),
	\degree, Pseq([[1, 5, 9], [1, 6, 9], [1, 6, 8], [-5, 1, 6, 8], \rest]),
	\rest, Pseq([1, 1, 1, 1, \rest]),
));

Pdef(\ch3, Pbind(
	\dur, Pseq(		[1, 		0.1, 		0.7, 		0.05, 		0.7, 		4]),
	\degree, Pseq([	[1, 5, 10, 14], 15, 	[1, 5, 9], 18, 		[0, 4, 6, 11, 14], 	\rest]),
	\rest, Pseq(	[1, 		1, 			1, 			1,			1,			\rest]),
	\legato, Pseq(	[4, 		2.4, 		2, 			0.1, 			10,			1])
));

Pdef(\ch4, Pbind(
	\dur, Pseq(		[0.6, 			0.6, 			1, 				1, 				4]),
	\legato, Pseq(	[1, 			1.4, 			3.8, 			10, 			1]),
	\degree, Pseq([[-1, 5, 9, 15],	[-1, 5, 8, 15], [-3, 6, 10, 15], [-5, -3, 6, 12], \rest]),
	\rest, Pseq([	1, 				1, 				1, 				1, 				\rest]),
));

);

(
Pdef(\epnR1, Pbind(
	\degree, Ptrace(Pseq([[0, -10], 0, 0, [-1, 2], 0, 0, 0, 0, [-3, 2], 0, 0, 0, -3, -6, -9], inf)),
)).trace;
Pdef(\epnR2, Pbind(
	\degree, Ptrace(Pseq([[0, -10], 0, [0, -10], [-1, 2, -10], 0, 0, [-1, -12], 0, [-3, 2, -14], 0, 0, 0, -3, -6, -9], inf)),
)).trace;
Pdef(\epnR3, Pbind(
	\degree, Ptrace(Pseq([[0, -10, 6], 0, [-1, -10, 4], [-1, -10, 2], 0, 0, [-1, -12, -4], 0, [-3, 4, -14], 4,
		[0, 9], [0, 11], [-4, 12], [-6, 8], [-9, -3, 9], [-9, -7, 10], -9, [-11, -4, 5]], inf)),
)).trace;
Pdef(\epnR4, Pbind(
	\degree, Ptrace(Pseq([[-3, 12], [-6, 8], [-9, -3, 9], [-9, -7, 10], [-11, -4, 5]], inf)),
)).trace;

Pdef(\epn, Pbind(
	\instrument, \epiano,
	\dur, Pseq([1], inf),
	\legato, 2,
	\vel, Prand([0.2, 0.3, 0.4, 0.3, 0.6], inf),
));
Pdef(\epn2, Pbind(
	\instrument, \epiano,
	\legato, 2,
	\vel, Pseq([0.2, 0.1, 0.3, 0.4, 1], inf),
	\dur, Pseq([1.5, 2.5, 2.5, 0.4, 2], inf),
	\degree, Pseq(-12 + [5, -1, -3, -1, 9], inf)
));
Pdef(\crashenv, Pbind(
	\crash, Pfunc({ var e = Env([1, 1.4, 8, 12, 5, 1.4, 1], [8, 4, 3, 2, 8, 2 ]); e.at(thisThread.seconds / 8 % e.duration) })
));

Pdef(\stutter2, Pbind(
	\dur, PdurStutter(Prand([1, 1, 1, 1, 1, 1.5], inf), Pkey(\dur)),
	\legato, Pkey(\legato) * 1.1,
	\retrig, Prand([16], inf)
));


//Pdef(\epnOut, Pdef(\stutter2) <> Pdef(\crashenv) <> Pdef(\epnR3) <> Pdef(\epn)).play;
Pdef(\epn2)
)