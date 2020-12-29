---
title: CSIDH, the Commutative SIDH protocol
filename: notes/csidh.md
---

# B-SIDH, the twist-agnostic SIDH protocol

Go to the [Previous page](../notes.md)
In 2018, Castryck, Lange, Martindale, Panny, and Renes proposed the CSIDH protocol [&#x5b;1&#x5d;](#CLMPR18), which can be viewed as a reinterpretation of Couveignes [&#x5b;3&#x5d;](#CouveignesXX) and Rostovtsev-Stolbunov [&#x5b;2](#BDLS20), [1&#x5d;](#ACDRH20) schemes but this time using supersingular curves defined over a prime field. 

The most demanding computational task of CSIDH is evaluating its class group action, whose cost is dominated by performing a number of degree-&#x2113; isogeny constructions/evaluations [^1].

Let E &#x2f; F<sub>p<sup>2</sup></sub> : By<sup>2</sup> = x<sup>3</sup> + Ax<sup>2</sup> + x be a supersingular elliptic curve with (p+1)<sup>2</sup> rational points, two rational points P<sub>a</sub>, Q<sub>a</sub> &#x220A; E&#x5b; p + 1&#x5d; of order M, and two zero-trace F<sub>p<sup>4</sup></sub>-rational points P<sub>b</sub>, Q<sub>b</sub> &#x220A; E&#x5b; p - 1&#x5d; of order N. Then, B-SIDH can be summarized as follows: 

| Alice  |     | Bob |
| ------ | :---: | ---: |
| sk<sub>a</sub> &#x27F5; &#x7b; 0, &#x2026;,  M - 1 &#x7d; <br/> R<sub>a</sub> = P<sub>a</sub> + [sk<sub>a</sub>]Q<sub>a</sub> <br/> &#x0278;<sub>a</sub> : E &#x27F6; E &#x2f; &#5176;R<sub>a</sub>&#5171; <br/> E<sub>a</sub> = E &#x2f; &#5176;R<sub>a</sub>&#5171; | E<sub>a</sub>, &#x0278;<sub>a</sub>(P<sub>b</sub>), &#x0278;<sub>a</sub>(Q<sub>b</sub>) <br/> &#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#5171; | |
| | E<sub>b</sub>, &#x0278;<sub>b</sub>(P<sub>a</sub>), &#x0278;<sub>b</sub>(Q<sub>a</sub>) <br/> &#5176;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015; | sk<sub>b</sub> &#x27F5; &#x7b; 0, &#x2026;,  N - 1 &#x7d; <br/> R<sub>b</sub> = P<sub>b</sub> + [sk<sub>b</sub>]Q<sub>b</sub> <br/> &#x0278;<sub>b</sub> : E &#x27F6; E &#x2f; &#5176;R<sub>b</sub>&#5171; <br/> E<sub>b</sub> = E &#x2f; &#5176;R<sub>b</sub>&#5171; |
| E<sub>a,b</sub> = E<sub>b</sub> &#x2f; &#5176;&#x0278;<sub>b</sub>(R<sub>a</sub>)&#5171; | | E<sub>a,b</sub> = E<sub>a</sub> &#x2f; &#5176;&#x0278;<sub>a</sub>(R<sub>b</sub>)&#5171; |

[^1]: You can deep into the isogeny evaluations/constructions on Montgomery curves by reading [&#x5b;4&#x5d;](#CH17) and [&#x5b;2](#BDLS20), [1&#x5d;](#ACDRH20) for the traditional and the new sqrt V&eacute;lu formul&aelig;, respectively.

---

**References**
: <a id="ACDRH20"></a> [1] G. Adj, J.-J. Chi-Dom&iacute;nguez, F. Rodr&iacute;guez-Henr&iacute;quez, **On new V&eacute;lu's formulae and their applications to CSIDH and B-SIDH constant-time implementations**. _IACR Cryptol. ePrint Arch._, 2020: 1109 (2020) [&#128279;](https://eprint.iacr.org/2020/1109).
: <a id="BDLS20"></a> [2] D. J. Bernstein, L. De Feo, A. Leroux, B. Smith, **Faster computation of isogenies of large prime degree**. _IACR Cryptol. ePrint Arch._, 2020: 341 (2020) [&#128279;](https://eprint.iacr.org/2020/341).
: <a id="CLMPR18"></a> [3] W. Castryck, T. Lange, C. Martindale, L. Panny, J. Renes, ** CSIDH: An Efficient Post-Quantum Commutative Group Action**. _Advances in Cryptology - ASIACRYPT 2018_, LNCS 11274, 395-427, 2018 [&#128279;](https://doi.org/10.1007/978-3-030-03332-3_15). 
: <a id="CH17"></a> [4] C. Costello, H&uuml;seyin Hisil, **A Simple and Compact Algorithm for SIDH with Arbitrary Degree Isogenies**. _Advances in Cryptology - ASIACRYPT 2017_, LNCS 10625, 303-329, 2017 [&#128279;](https://doi.org/10.1007/978-3-319-70697-9_11).

---
