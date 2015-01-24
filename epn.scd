/*

State(\epn).doInit();
State(\epn).doStart();


*/
(
Pdef(\epn_play, Pbind(
	\degree, 0,
	\octave, 2,
	\dur, 0.5,
	\dropNote, Pembed(Pshuf([
		Pseq([
			Prand([
				(\degree: [0, -16],	 	\dur: 0.05, \legato: 10 / 0.05),
				(\degree: [4, -10], 	\dur: 0.05, \legato: 10 / 0.05),
			]),
			Prand([
				(\degree: 2 + 4,		\dur: 0.4, \vel: 0.1, \legato: 4),
				(\degree: 2 + 6,		\dur: 0.4, \vel: 0.3, \legato: 4),
				(\degree: 2 + 4  + 12,	\dur: 0.4, \vel: 1.0, \legato: 10, \crash:0),
			])
		], 1),
		(), (), (), (), ()
	], inf))
) <> Pdef(\epn_out) <> Pdef(\epn_base)
).play;
)

State(\epn).clear;
State(\epn).push;

State(\epn).initActions.add({
	Require("epn-synthdef");
	Require("epn-patterns");

	~resources.addAll([
		~noteGroup = Group(s),
		~postGroup = Group(~noteGroup, 'addAfter'),
		~noteBus = Bus.audio(s, 2),
	]);

	Pdef(\epn_out, Pbind(
		\out, ~noteBus.index
	));
});

State(\epn).startActions.add({
	Ndef(\rev, {
		var revSigL, revSigR, sig;
		sig = In.ar(~noteBus.index, 2);
		revSigL = GVerb.ar(sig[0], 10, 4, 0.4) * 0.2;
		revSigR = GVerb.ar(sig[1], 10, 4, 0.4) * 0.2;
		[ sig[0] + Balance2.ar(revSigL[0], revSigL[1], -0.7),
			sig[1] + Balance2.ar(revSigR[0], revSigR[1], 0.7) ]
	}).play();
	Ndef(\rev).parentGroup = ~postGroup;

	Pdef(\epn_play,
		Pdef(\epn_out) <> Pdef(\epn_base)
	).play;
});

State(\epn).stopActions.add({

});

State(\epn).freeActions.add({

});

