---
title: CSIDH, the Commutative SIDH protocol
filename: notes/csidh.md
---

# CSIDH, the Commutative SIDH protocol

---

Go to the [Previous page](../notes.md)
In 2018, Castryck, Lange, Martindale, Panny, and Renes proposed the CSIDH protocol [&#x5b;1&#x5d;](#CLMPR18), which can be viewed as a reinterpretation of Couveignes [&#x5b;3&#x5d;](#CouveignesXX) and Rostovtsev-Stolbunov [&#x5b;2](#BDLS20), [1&#x5d;](#ACDRH20) schemes but this time using supersingular curves defined over a prime field. 

The most demanding computational task of CSIDH is evaluating its class group action, whose cost is dominated by performing a number of degree-&#x2113; isogeny constructions/evaluations [^1].

Let E &#x2f; F<sub>p</sub> : By<sup>2</sup> = x<sup>3</sup> + Ax<sup>2</sup> + x be a supersingular elliptic curve with (p + 1) rational points, and m &#x220A; Z. Then, CSIDH can be summarized as follows: 

```mermaid
graph TD
    START(Start) -- "To process the i-th entry" --> IF1{"Has m<sub>i</sub> degree-ℓ<sub>i</sub><br/>isogeny constructions<br/>been permformed?"};
    subgraph " "
    IF1 -- No --> IF2{"e<sub>i</sub> == 0?"};
    IF2 -- Yes --> WD[/"To perform a<br/>dummy-isogeny<br/>construction"/];
    IF2 -- No --> DF[/"To perform a<br/>degree-ℓ isogeny<br/>evaluation"/];
    DF --> DEC["e<sub>i</sub> -= 1"];
    WD --> FIN{"Are there missing<br/>isogeny constructions?"}
    DEC -->FIN;
    FIN -- Yes --> IF1;
    end
    FIN -- No --> END(End);
   
```

[^1]: You can deep into the isogeny constructions/evaluations on Montgomery curves by reading [&#x5b;4&#x5d;](#CH17) and [&#x5b;2](#BDLS20), [1&#x5d;](#ACDRH20) for the traditional and the new sqrt V&eacute;lu formul&aelig;, respectively.

---

**References**
: <a id="ACDRH20"></a> [1] G. Adj, J.-J. Chi-Dom&iacute;nguez, F. Rodr&iacute;guez-Henr&iacute;quez, **On new V&eacute;lu's formulae and their applications to CSIDH and B-SIDH constant-time implementations**. _IACR Cryptol. ePrint Arch._, 2020: 1109 (2020) [&#128279;](https://eprint.iacr.org/2020/1109).
: <a id="BDLS20"></a> [2] D. J. Bernstein, L. De Feo, A. Leroux, B. Smith, **Faster computation of isogenies of large prime degree**. _IACR Cryptol. ePrint Arch._, 2020: 341 (2020) [&#128279;](https://eprint.iacr.org/2020/341).
: <a id="CLMPR18"></a> [3] W. Castryck, T. Lange, C. Martindale, L. Panny, J. Renes, ** CSIDH: An Efficient Post-Quantum Commutative Group Action**. _Advances in Cryptology - ASIACRYPT 2018_, LNCS 11274, 395-427, 2018 [&#128279;](https://doi.org/10.1007/978-3-030-03332-3_15). 
: <a id="CH17"></a> [4] C. Costello, H&uuml;seyin Hisil, **A Simple and Compact Algorithm for SIDH with Arbitrary Degree Isogenies**. _Advances in Cryptology - ASIACRYPT 2017_, LNCS 10625, 303-329, 2017 [&#128279;](https://doi.org/10.1007/978-3-319-70697-9_11).

---
