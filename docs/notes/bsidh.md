---
layout: default
title: B-SIDH, the twist-agnostic SIDH protocol
filename: notes/bsidh.md
---

# B-SIDH, the twist-agnostic SIDH protocol

In the B-SIDH protocol proposed by Costello in [&#x5b;4&#x5d;](#Costello20), Alice and Bob work in the (p + 1)- and (p - 1)-torsion of a set of supersingular curves defined over &#x1D53D;<sub>p<sup>2</sup></sub> and the set of their quadratic twist, respectively. In summary, B-SIDH can be viewed as a twist agnostic of SIDH protocol [^1], which allows an optimized isogeny and Montgomery arithmetic by only using the x-coordinate of the points along with the A coefficient of the curve.

Let E &#x2f; &#x1D53D;<sub>p<sup>2</sup></sub> : By<sup>2</sup> = x<sup>3</sup> + Ax<sup>2</sup> + x be a supersingular elliptic curve with (p+1)<sup>2</sup> rational points, two rational points P<sub>a</sub>, Q<sub>a</sub> &#x220A; E&#x5b; p + 1&#x5d; of order M, and two zero-trace &#x1D53D;<sub>p<sup>4</sup></sub>-rational points P<sub>b</sub>, Q<sub>b</sub> &#x220A; E&#x5b; p - 1&#x5d; of order N. Now, let's denote by E &#x2f; &#5176;R&#5171; to the co-domain curve of the separable isogeny &#x0278; : E &#x27F6; E &#x2f; &#5176;R&#5171; with kernel generated by R. Then, B-SIDH can be summarized as follows: 

<table class="table table-striped lead">
	<thead>
	<tr>
		<th>Alice</th>
		<th class="text-center"></th>
		<th class="text-right">Bob</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td><small>sk<sub>a</sub> &#x27F5; &#x7b;0, &#x2026;,  M - 1&#x7d; <br/> R<sub>a</sub> = P<sub>a</sub> + [sk<sub>a</sub>]Q<sub>a</sub> <br/> &#x0278;<sub>a</sub> : E &#x27F6; E &#x2f; &#5176;R<sub>a</sub>&#5171; <br/> E<sub>a</sub> = E &#x2f; &#5176;R<sub>a</sub>&#5171;</small></td>
		<td class="text-center"><small><br/><br/>E<sub>a</sub>, &#x0278;<sub>a</sub>(P<sub>b</sub>), &#x0278;<sub>a</sub>(Q<sub>b</sub>) <br/> &#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#5171;</small></td>
		<td class="text-right"><small></small></td>
    </tr>
	<tr>
		<td><small></small></td>
		<td class="text-center"><small><br/><br/>E<sub>b</sub>, &#x0278;<sub>b</sub>(P<sub>a</sub>), &#x0278;<sub>b</sub>(Q<sub>a</sub>) <br/> &#5176;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;&#x2015;</small></td>
		<td class="text-right"><small>sk<sub>b</sub> &#x27F5; &#x7b;0, &#x2026;,  N - 1&#x7d; <br/> R<sub>b</sub> = P<sub>b</sub> + [sk<sub>b</sub>]Q<sub>b</sub> <br/> &#x0278;<sub>b</sub> : E &#x27F6; E &#x2f; &#5176;R<sub>b</sub>&#5171; <br/> E<sub>b</sub> = E &#x2f; &#5176;R<sub>b</sub>&#5171;</small></td>
    </tr>
	<tr>
		<td><small>E<sub>a,b</sub> = E<sub>b</sub> &#x2f; &#5176;&#x0278;<sub>b</sub>(R<sub>a</sub>)&#5171;</small></td>
		<td class="text-center"><small></small></td>
		<td class="text-right"><small>E<sub>a,b</sub> = E<sub>a</sub> &#x2f; &#5176;&#x0278;<sub>a</sub>(R<sub>b</sub>)&#5171;</small></td>
    </tr>
	</tbody>
</table>

The protocol flow of B-SIDH must perform two main phases, namely, key generation (`keygen`) and secret sharing (`derive`). In practice, the `keygen` block performs the isogeny evaluation of the projectivized x-coordinate points x(P), x(Q), and x(P - Q) [^2]. Thus for B-SIDH, `derive` is significantly cheaper than `keygen`. However, the most important challenge in any implementation of B-SIDH corresponds with the high computational cost associated with the large degree of isogenies involved in its execution [^3]; in contrast, B-SIDH also allows to work over smaller fields than SIDH does.

Regarding B-SIDH security, the task of an attacker is to find an isogeny between two supersingular curves E<sub>1</sub> &#x2f; &#x1D53D;<sub>p<sup>2</sup></sub> and E<sub>2</sub> &#x2f; &#x1D53D;<sub>p<sup>2</sup></sub>, and the best classical and quantum procedures to forge it are the Delfs-Galbraith [&#x5b;8&#x5d;](#DG16) algorithm and its quantum adaptation due to Biasse-Jao-Sankar [&#x5b;3&#x5d;](#BJS14), which have a running time of O(p<sup>&#xBD;</sup>) and O(p<sup>&#xBC;</sup>) with "negligible" memory requirements, respectively.

[^1]: For more details regarding the SIDH protocol, to read [&#x5b;6&#x5d;](#DJ11) and [&#x5b;7&#x5d;](#DJP14).
[^2]: Here, P &#x220A; &#x7b;P<sub>a</sub>, P<sub>b</sub>&#x7d;, and  Q &#x220A; &#x7b;Q<sub>a</sub>, Q<sub>b</sub>&#x7d;.
[^3]: You can deep into the isogeny constructions/evaluations on Montgomery curves by reading [&#x5b;5&#x5d;](#CH17) and [&#x5b;2](#BDLS20), [1&#x5d;](#ACDRH20) for the traditional and the new sqrt V&eacute;lu formul&aelig;, respectively.

---

**References**
: <a id="ACDRH20"></a> [1] G. Adj, J.-J. Chi-Dom&iacute;nguez, F. Rodr&iacute;guez-Henr&iacute;quez, **Karatsuba-based square-root Vélu’s formulas applied to two isogeny-based protocols**. _IACR Cryptol. ePrint Arch._, 2020: 1109 (2020) [&#128279;](https://eprint.iacr.org/2020/1109).
: <a id="BDLS20"></a> [2] D. J. Bernstein, L. De Feo, A. Leroux, B. Smith, **Faster computation of isogenies of large prime degree**. _IACR Cryptol. ePrint Arch._, 2020: 341 (2020) [&#128279;](https://eprint.iacr.org/2020/341).
: <a id="BJS14"></a> [3] J.-F. Biasse, D. Jao, and A. Sankar, **A Quantum Algorithm for Computing Isogenies between Supersingular Elliptic Curves**, _Progress in Cryptology - INDOCRYPT 2014_, LNCS 8885, 428-442, 2014 [&#128279;](https://doi.org/10.1007/978-3-319-13039-2_25).
: <a id="Costello20"></a>[4] C. Costello, **B-SIDH: Supersingular Isogeny Diffie-Hellman Using Twisted Torsion**. _Advances in Cryptology - ASIACRYPT 2020_, LNCS 12492, 440-463, 2020 [&#128279;](https://doi.org/10.1007/978-3-030-64834-3_15).
: <a id="CH17"></a> [5] C. Costello, H&uuml;seyin Hisil, **A Simple and Compact Algorithm for SIDH with Arbitrary Degree Isogenies**. _Advances in Cryptology - ASIACRYPT 2017_, LNCS 10625, 303-329, 2017 [&#128279;](https://doi.org/10.1007/978-3-319-70697-9_11).
: <a id="DJ11"></a> [6] L. De Feo, and D. Jao, **Towards Quantum-Resistant Cryptosystems from Supersingular Elliptic Curve Isogenies**. _Post-Quantum Cryptography - PQCrypto 2011_, LNCS 7071, 19-34, 2011 [&#128279;](https://doi.org/10.1007/978-3-642-25405-5_2).
: <a id="DJP14"></a> [7] L. De Feo, D. Jao, and J. Pl&ucirc;t, **Towards quantum-resistant cryptosystems from supersingular elliptic curve isogenies**, _Journal of Mathematical Cryptology_, 8 (3), 209-247, 2014 [&#128279;](https://doi.org/10.1515/jmc-2012-0015).
: <a id="DG16"></a> [8] C. Delfs, and S. D. Galbraith, **Computing isogenies between supersingular elliptic curves over &#x1D53D;<sub>p</sub>**, _Designs, Codes and Cryptography_, 78 (2), 425-400, 2016 [&#128279;](https://doi.org/10.1007/s10623-014-0010-1).

---
