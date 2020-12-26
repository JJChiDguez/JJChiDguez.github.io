---
title: The twist-agnostic SIDH protocol, named B-SIDH
filename: notes/bsidh.md
---

# The twist-agnostic SIDH protocol, named B-SIDH

Go to the [Previous page](notes.md)

In the B-SIDH protocol proposed by Costello in [1], Alice and Bob work in the (p + 1)- and (p - 1)-torsion of a set of supersingular curves defined over F<sub>p<sup>2</sup></sub> and the set of their quadratic twist, respectively. Certainly, B-SIDH can be viewed as a twist agnostic of SIDH protocol [^1], it allows optimized isogeny and Montgomery arithmetic by only using the x-coordinate of the points along with the A coefficient of the curve.

To be more precise, let E &#x2f; F<sub>p<sup>2</sup></sub> : By<sup>2</sup> = x<sup>3</sup> + Ax<sup>2</sup> + x be a supersingular elliptic curve with (p+1)<sup>2</sup> rational points, two rational points P<sub>a</sub>, Q<sub>a</sub> &#x220A; E&#x5b; p + 1&#x5d; of order M, and two zero-trace F<sub>p<sup>4</sup></sub> rational points P<sub>b</sub>, Q<sub>b</sub> &#x220A; E&#x5b; p - 1&#x5d; of order N. Then, B-SIDH can be summarized as follows: 

| Alice  |     | Bob |
| ------ | :---: | ---: |
| sk<sub>a</sub> &#x27F5; &#x7b; 0, &#x2026;,  M - 1 &#x7d; <br/> R<sub>a</sub> = P<sub>a</sub> + [sk<sub>a</sub>]Q<sub>a</sub> <br/> &#x0278;<sub>a</sub> : E &#x27F6; E &#x2f; &#5176;R<sub>a</sub>&#5171; <br/> E<sub>a</sub> = E &#x2f; &#5176;R<sub>a</sub>&#5171; | E<sub>a</sub>, &#x0278;<sub>a</sub>(P<sub>b</sub>), &#x0278;<sub>a</sub>(Q<sub>b</sub>) <br/> &#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#11166; | |
| | E<sub>b</sub>, &#x0278;<sub>b</sub>(P<sub>a</sub>), &#x0278;<sub>b</sub>(Q<sub>a</sub>) <br/> &#11164;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015; | sk<sub>b</sub> &#x27F5; &#x7b; 0, &#x2026;,  N - 1 &#x7d; <br/> R<sub>b</sub> = P<sub>b</sub> + [sk<sub>b</sub>]Q<sub>b</sub> <br/> &#x0278;<sub>b</sub> : E &#x27F6; E &#x2f; &#5176;R<sub>b</sub>&#5171; <br/> E<sub>b</sub> = E &#x2f; &#5176;R<sub>b</sub>&#5171; |
| E<sub>a,b</sub> = E<sub>b</sub> &#x2f; &#5176;&#x0278;<sub>b</sub>(R<sub>a</sub>)&#5171; | | E<sub>a,b</sub> = E<sub>a</sub> &#x2f; &#5176;&#x0278;<sub>a</sub>(R<sub>b</sub>)&#5171; |

[^1]: For more details regarding the SIDH protocol, to read [2](https://doi.org/10.1007/978-3-642-25405-5_2) and [3](https://doi.org/10.1515/jmc-2012-0015).

---
### References
[1](https://doi.org/10.1007/978-3-030-64834-3_15) C. Costello, **B-SIDH: Supersingular Isogeny Diffie-Hellman Using Twisted Torsion**. _Advances in Cryptology - ASIACRYPT 2020_, LNCS 12492, 440-463, 2020.
[2](https://doi.org/10.1007/978-3-642-25405-5_2) L. De Feo, and D. Jao, **Towards Quantum-Resistant Cryptosystems from Supersingular Elliptic Curve Isogenies**. _Post-Quantum Cryptography - PQCrypto 2011_, LNCS 7071, 19-34, 2011.
[3](https://doi.org/10.1515/jmc-2012-0015) L. De Feo, D. Jao, and J. Pl&ucirc;t, **Towards quantum-resistant cryptosystems from supersingular elliptic curve isogenies**, _Journal of Mathematical Cryptology_, 8 (3), 209-247, 2014.
