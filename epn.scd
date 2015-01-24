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
});

State(\epn).startActions.add({
	Ndef(\rev, {
		var revSigL, revSigR, sig;
		sig = In.ar(~noteBus.busnum, 2);
		revSigL = GVerb.ar(sig[0], 10, 4, 0.4) * 0.2;
		revSigR = GVerb.ar(sig[1], 10, 4, 0.4) * 0.2;
		[ sig[0] + Balance2.ar(revSigL[0], revSigL[1], -0.7),
			sig[1] + Balance2.ar(revSigR[0], revSigR[1], 0.7) ]
	}).play(target:~postGroup);
});

State(\epn).stopActions.add({

});

State(\epn).freeActions.add({

});

