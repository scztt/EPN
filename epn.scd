/*

State(\epn).doInit();
State(\epn).doStart();


*/
(
Pdef(\longDeepBase, Pbind(
	\vel, 0.2,		\octave, 2,		\vel, 0.2,		\amp, 0.6,		\crash, 0.1,	\sustain, 4,   \retrig, 0
) <> Pdef(\epn_base));

Pdef(\highModBase, Pdef(\epn_base) <> Pbind(
	\vel, 0.2,		\octave, 5,		\amp, 0.5,		\crash, 0.3,
));

Pdef(\epn_play, Pdef(\epn_out) <>
	Ptpar([

		0: (\degree: 1, \vel: 0.2, \crash: 0.1, \sustain: 30).bindOnce,
		6: (\degree: 3, \vel: 0.1, \crash: 0.1, \sustain: 20).bindOnce,
		10: (\degree: 1, \octave:7,  \vel: 0.3, \crash: 1.2, \amp: 0.1, \sustain: 0.1).bindOnce,
		14: (\degree: 1, \octave:7,  \vel: 0.4, \crash: 1.2, \amp: 0.1, \sustain: 0.1).bindOnce,
	]) <> Pdef(\longDeepBase)
);
Pdef(\epn_play).play;
)

(
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
		revSigL = GVerb.ar(sig[0], 10, 4, 0.9) * 0.2;
		revSigR = GVerb.ar(sig[1], 10, 4, 0.9) * 0.2;
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
)
