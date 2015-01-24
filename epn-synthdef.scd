SynthDef(\epiano, {
	| out=0, freq, amp = 1, dur=1, gate=1, vel = 0.75, retrig = 0, crash=1 |
	var sig, fmSig, noise, env, linenv, ctls, mods, mult, timescale, at,
	attack, scale, vib, filtf, a, lfo;

	freq = Select.kr(retrig > 0, [
		freq,
		freq * Select.kr(TRand.kr(0, 4, Dust.kr(retrig)), [1, 1, 1, 2])
	]);

	timescale = vel.linlin(0, 1, dur * 0.5, dur * 2.2);
	attack = vel.linexp(0, 1, 0.03, 0.001);
	scale = vel.linexp(0, 1, 0.4, 1.5);
	vib = vel.linexp(0, 1, 0.05, 0.2);
	filtf = vel.linlin(0, 1, 1500, 3600);
	lfo = SinOsc.ar(2.1, Rand(-2, 2), 2.3 * EnvGen.kr(Env.linen(0.01, 1, 5), gate:gate));
	freq = freq + lfo;
	ctls = [
		[ freq * 2 - 0.6, 	Rand(-pi, pi), 		EnvGen.kr(Env.adsr(attack, 1, 0.01, 0.1, curve:0), timeScale:timescale, gate:gate)	],
		[ freq,				Rand(-pi, pi),		EnvGen.kr(Env.adsr(attack, 0.5, 0.6, 0.5), timeScale:timescale, gate:gate) ],
		[ freq * 2 + 0.3,	Rand(-pi, pi),		EnvGen.kr(Env.adsr(attack, 0.9, 0.4, 0.1), timeScale:timescale, gate:gate)	],
		[ freq + 0.21,		Rand(-pi, pi),		EnvGen.kr(Env.adsr(attack, 0.5, 0.2, 0.5), timeScale:timescale, gate:gate)	],
		[ freq * 2,			Rand(-pi, pi),		EnvGen.kr(Env.adsr(attack, 0.5, 0.3, 0.5), timeScale:timescale, gate:gate)	],
		//[ freq * 5.4969 + 2000, Rand(-pi, pi), 	EnvGen.kr(Env.adsr(0.01, 0.2, 0.1, 0.8), timeScale:timescale, gate:gate)	],
		[ freq * 0.5 + 10.1,Rand(-pi, pi), 		EnvGen.kr(Env.adsr(attack, 0.2, 0.1, 0.8), timeScale:timescale, gate:gate) ],
	];
	mult = crash * pi;
	mods = [
		[ 0,	0, 	0, 	0, 	0.35, 	vib ] * mult * scale,
		[ 0.29,	0, 	0, 	0, 	0, 		0 ] * mult * scale,
		[ 0,	0, 	0, 	0, 	0.29, 	0 ] * mult * scale,
		[ 0,	0, 	0.33, 	0, 	0, 	0 ] * mult * scale,
		[ 0,	0, 	0, 	0, 	0, 		0 ] * mult * scale,
		[ 0,	0, 	0, 	0, 	0.26, 	0 ] * mult * scale,
	];
	fmSig = FM7.ar(ctls, mods);
	sig = (
		 Pan2.ar(	fmSig[0], 	-0.28,	0.41)
		 + Pan2.ar(	fmSig[1], 	-0.19,	0.31)
		 + Pan2.ar(	fmSig[2], 	-0.15,	0.28)
		 + Pan2.ar(	fmSig[3], 	0.28,	0.44)
		 //+ Pan2.ar(	fmSig[4], 	-0.15,	0.0)
		 //+ Pan2.ar(	fmSig[5], 	-0.16,	0.16)
	);
	noise = SoftClipAmp4.ar(
		(fmSig[1] * 0.43)
		+ (fmSig[3] * 0.59)
		+ (fmSig[4] * 0.61),
		vel.linlin(0, 1, 0.2, 1.8)
	);
	noise = Pan2.ar(noise, -34, 0.34);
	sig = sig + noise;
	sig = MoogVCF.ar(sig, filtf, 0.4);
	sig = Rotate2.ar(sig[0], sig[1], 0.5);
	sig = sig * EnvGen.kr(Env([1, 1, 0], [1, 2], releaseNode:1), gate:Impulse.kr(0) + gate, doneAction:2);
	a = DetectSilence.ar(sig[0], doneAction:2);
	amp = amp * vel.linlin(0, 1, -6.dbamp, 0.dbamp);
	Out.ar(out, sig * amp)
}).addReplace;