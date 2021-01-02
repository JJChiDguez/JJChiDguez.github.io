---
title: Let's introduce a couple of Lattice-based cryptanalysises
filename: notes/lattices-at-work.md
---

# Let's introduce a couple of Lattice-based cryptanalysises

Go to the [Previous page](../notes.md)

In both **DSA** and **ECDSA** (the elliptic-curve **DSA**) procedures, the signature output is a pair (r,s) of integer numbers such that
<center><a id="signature-rs"></a> s &#xd7; k &#x2261; &#x28; h + &#x3B1; &#xd7; r &#x29; mod q,</center>
where &#x3B1;, h, and k are the private key, the hash of the message to be signed, and the _ephemeral_ key [^1], respectively. In particular, r is either the output of the exponentiation (**DSA** case: g<sup>k</sup>) or the scalar point multiplication (**ECDSA** case: &#x5b;k&#x5d;P) procedure.

The following lattice descriptions are based on the results presented in [&#x5b;4&#x5d;](#DEJAVU20), which is more focused on the practical Side-Channel Analysis. However, for a deep read, I suggest the paper by [Gabrielle De Micheli and Nadia Heninger](#MH20).


### Timing attacks

Lattice-based cryptanalysis using timing attacks are commonly focused on determining a few bits from the _ephemeral_ key, which can be easily correlated with the private key by using the [above equation](#signature-rs). For instance, if the exponentiation or scalar point multiplication procedures have been implemented in _**non**_-constant-time, then by a simple timing analysis it is possible to find a sample of d signatures (r<sub>i</sub>, s<sub>i</sub>) with shorter-than-average _ephemeral_ key k<sub>i</sub> &#x3c; q / 2<sup>&#x2113;<sub>i</sub></sup> for some positive integer &#x2113;<sub>i</sub>. Moreover, the dimensional-(d+1) lattice

| <br/><br/>B =<br/> | &#x5b; 2W<sub>1</sub> &#xd7; q <br/>&#x5b; 0 <br/>&#x5b; &#x22EE; <br/>&#x5b; 0 | 0 <br/>2W<sub>2</sub> &#xd7; q <br/>&#x22F1; <br/>&#x22EF; | &#x22EF; <br/>&#x22F1; <br/>&#x22F1; <br/>0 | &#x22EF; <br/>&#x22EF; <br/>0  <br/>2W<sub>d</sub> &#xd7; q | 0 &#x5d; <br/>&#x22EE; &#x5d; <br/>&#x22EE; &#x5d; <br/>0 &#x5d; |
| ---: | :---                   | :---           | :---    | :---    | ---:       |
|     | &#x5b; 2W<sub>1</sub> &#xd7; t<sub>1</sub> | 2W<sub>2</sub> &#xd7; t<sub>2</sub> | &#x22F1; | 2W<sub>d</sub> &#xd7; t<sub>d</sub> | 1 &#x5d;    |

and the integer vectors u = &#x28; 2W<sub>1</sub> &#xd7; &ucirc;<sub>1</sub> + q, &#x2026;, 2W<sub>1</sub> &#xd7; &ucirc;<sub>1</sub> + q, 0  &#x29;, z = &#x28; &#x03BB;<sub>1</sub>, &#x2026;, &#x03BB;<sub>d</sub>, &#x3B1; &#x29;, and y = &#x28; 2W<sub>1</sub> &#xd7; &#x03BD;<sub>1</sub>, &#x2026;, 2W<sub>d</sub> &#xd7; &#x03BD;<sub>d</sub>, &#x3B1; &#x29; satisfy zB - u = y with  W<sub>i</sub> = 2<sup>&#x2113;<sub>i</sub></sup>, &#x03BB;<sub>i</sub> &#x220A; &#x7b; -q, &#x2026;, q &#x7d;, and &#x03BD;<sub>i</sub> &#x220A; &#x7b; -(q - 1)/2, &#x2026;, (q - 1)/2 &#x7d; the signed modular reduction of &ucirc;<sub>i</sub> + q/(2W<sub>i</sub>) mod q.

In other words, the private key &#x3B1; recovery can be reduced to a Closest Vector Problem (CVP) instance of a given lattice. However, any CVP instance with input lattice B and vector u can be mapped into a Shortest Vector Problem (SVP) instance by looking for a short lattice basis vector in the dimensional-(d + 2) lattice B'


| &#x5b; B | 0 &#x5d; |
| ---:     | :---     |
| &#x5b; u | q &#x5d; |

### wNAF trace approach

Let's focus on scalar point multiplications using wNAF scalar codifications. Assuming a window width equals w, two kwnon consecutive non-zero coefficients &#x03BA;<sub>j</sub> and &#x03BA;<sub>j + &#x2113;</sub> leads to an equation with &#x03B4; &#x3B1;-correlated bits. Each column of the lattice B (with same shape as given above), is determined by the pair (&#x03BA;<sub>j</sub>, &#x03BA;<sub>j + &#x2113;</sub>) along with the public values h and (r,s).

In particular, the entries of the integer vector t coincide with r &#xd7; s<sup>-1</sup> &#xd7; 2<sup>m - j - &#x2113; - 1</sup> mod q, W = 2<sup>&#x03B4;</sup> where &#x03B4; is equal to (&#x2113; - w) and (&#x2113; - w + 1) for the unsigned and signed approaches [^2], respectively. In both cases, the integer vector has the same shape like in the timing attack but  without the term q, and the entries of u are equal to

- 2<sup>m + w - &#x2113; - 1</sup> - (r &#xd7; s<sup>-1</sup> + 2<sup>j + w</sup> - 2<sup>j + &#x2113;</sup>) &#xd7; 2<sup>m - j - &#x2113; - 1</sup> mod q for the unsigned case (for more details [&#x5b;5&#x5d;](#PSY15)); or
- (2b + 1) &#xd7; 2<sup>m + w - &#x2113; - 2</sup> - (r &#xd7; s<sup>-1</sup> &#xd7; 2<sup>m - j - &#x2113; - 1</sup>) mod q, where b denotes the sign of &#x03BA;<sub>j + &#x2113;</sub> (for more details [&#x5b;1&#x5d;](#ABFPY16)).


### Solving the lattice

In both SVP and CVP instances, one proceeds by reducing the lattice with the LLL or BKZ procedures. But in practice, one proceeds by applying the method by Gama et al. [&#x5b;3&#x5d;](#GNR10), which can be summarized as follows:

- To reduce (using BKZ) another dimensional-(d + 2) lattice &#x03B2; which is computed by shuffling the columns of B' and multiplying it by a unimodular matrix with low density approximately; 
- To look for a short lattice basis vector in the reduced lattice of &#x03B2;: if private key recovery is unsuccessful, update &#x03B2; as the reduced matrix of &#x03B2; and repeat the procedure.

[^1]: In some papers, the integer k is named by _nonce_ but in my opinion, I prefer the term _ephemeral_ key.
[^2]: The unsigned case refers when it is only possible to determine non-zero wNAF-coefficients, and thus the signed case allows to guess the sign of the wNAF-coefficients.

---

**References**
: <a id="ABFPY16"></a> [1] T. Allan, B. Brumley, K. Falkner, J. van de Pol, Y. Yarom, **Amplifying side channels through performance degradation**, _Annual Computer Security Applications Conference - ACSAC 2016_, ACM (2016), 422-435 [&#128279;](https://dl.acm.org/doi/10.1145/2991079.2991084);
: <a id="MH20"></a> [2] G. De Micheli and N. Heninger, **Recovering cryptographic keys from partial information, by example**, IACR Cryptol. ePrint Arch. 2020: 1506 (2020) [&#128279;](https://eprint.iacr.org/2020/1506);
: <a id="GNR10"></a> [3] N. Gama, P. Nguyen, O. Regev, **Lattice Enumeration Using Extreme Pruning**, _Advances in Cryptology - EUROCRYPT 2010_, LNCS 6110, 257-278, 2010 [&#128279;](https://link.springer.com/chapter/10.1007%2F978-3-642-13190-5_13);
: <a id="DEJAVU20"></a> [4] S. ul Hassan, I. Gridin, I. Delgado-Lozano, C. Pereida-Garc&iacute;a, J.-J. Chi-Dom&iacute;nguez, A. Cabrera Aldaya, B. Brumley, **D&eacute;j&agrave; Vu: Side-Channel Analysis of Mozilla's NSS**, Conference on Computer and Communications Security - CCS 2020, ACM (2020), 1887-1902 [&#128279;](https://doi.org/10.1145/3372297.3421761);
: <a id="PSY15"></a> [5] J. van de Pol, N. Smart, Y. Yarom, **Just a Little Bit More**, _Topics in Cryptology - CT-RSA 2015_, LNCS 9048, 3-21, 2015 [&#128279;](https://doi.org/10.1007/978-3-319-16715-2_1).

---
