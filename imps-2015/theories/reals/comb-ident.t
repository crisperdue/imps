;% Copyright (c) 1990-1994 The MITRE Corporation
;% 
;% Authors: W. M. Farmer, J. D. Guttman, F. J. Thayer
;%   
;% The MITRE Corporation (MITRE) provides this software to you without
;% charge to use, copy, modify or enhance for any legitimate purpose
;% provided you reproduce MITRE's copyright notice in any copy or
;% derivative work of this software.
;% 
;% This software is the copyright work of MITRE.  No ownership or other
;% proprietary interest in this software is granted you other than what
;% is granted in this license.
;% 
;% Any modification or enhancement of this software must identify the
;% part of this software that was modified, by whom and when, and must
;% inherit this license including its warranty disclaimers.
;% 
;% MITRE IS PROVIDING THE PRODUCT "AS IS" AND MAKES NO WARRANTY, EXPRESS
;% OR IMPLIED, AS TO THE ACCURACY, CAPABILITY, EFFICIENCY OR FUNCTIONING
;% OF THIS SOFTWARE AND DOCUMENTATION.  IN NO EVENT WILL MITRE BE LIABLE
;% FOR ANY GENERAL, CONSEQUENTIAL, INDIRECT, INCIDENTAL, EXEMPLARY OR
;% SPECIAL DAMAGES, EVEN IF MITRE HAS BEEN ADVISED OF THE POSSIBILITY OF
;% SUCH DAMAGES.
;% 
;% You, at your expense, hereby indemnify and hold harmless MITRE, its
;% Board of Trustees, officers, agents and employees, from any and all
;% liability or damages to third parties, including attorneys' fees,
;% court costs, and other related costs and expenses, arising out of your
;% use of this software irrespective of the cause of said liability.
;% 
;% The export from the United States or the subsequent reexport of this
;% software is subject to compliance with United States export control
;% and munitions control restrictions.  You agree that in the event you
;% seek to export this software or any derivative work thereof, you
;% assume full responsibility for obtaining all necessary export licenses
;% and approvals and for assuring compliance with applicable reexport
;% restrictions.
;% 
;% 
;% COPYRIGHT NOTICE INSERTED: Mon Apr 11 11:42:27 EDT 1994


(herald COMB-IDENT)

(load-section foundation)

(def-theorem factorial-of-zero
  "0!=1"
  (theory h-o-real-arithmetic)
  (proof
   (

    (unfold-single-defined-constant-globally factorial)
    (unfold-single-defined-constant-globally prod)
    simplify

    )))

(def-compound-macete factorial-reduction
  (without-minor-premises
   (repeat factorial-out factorial-of-zero)))

(def-script comb-ident-script 0
  ((unfold-single-defined-constant-globally comb)
   (apply-macete-with-minor-premises fractional-expression-manipulation)
   (label-node compound)
   direct-and-antecedent-inference-strategy
   (jump-to-node compound)
   (for-nodes
    (unsupported-descendents)
    (if (matches? "with(t:rr, #(t^[-1]))")
	(apply-macete-with-minor-premises definedness-manipulations)
	(block
	  (apply-macete-with-minor-premises factorial-reduction)
	  simplify)))))

(def-theorem comb-ident
  "forall(k,m:zz,1<=k and k<=m implies comb(1+m,k)=comb(m,k-1)+comb(m,k))"
  (theory h-o-real-arithmetic)
  (proof
   (

    (unfold-single-defined-constant-globally comb)
    (apply-macete-with-minor-premises fractional-expression-manipulation)
    direct-and-antecedent-inference-strategy
    (apply-macete-with-minor-premises definedness-manipulations)
    (apply-macete-with-minor-premises definedness-manipulations)
    (block (apply-macete-with-minor-premises factorial-reduction) simplify)

    )))

(def-theorem comb-0-value-lemma
  "forall(m:zz,0<=m implies comb(m,0)=1)"
  (proof
   (
 
    (unfold-single-defined-constant (0) comb)
    simplify
    (unfold-single-defined-constant (0) factorial)
    (unfold-single-defined-constant (0) prod)
    simplify

    ))
  (theory h-o-real-arithmetic))

(def-theorem comb-1-value-lemma
  "forall(m:zz,1<=m implies comb(m,1)=m)"
  (theory h-o-real-arithmetic)
  (proof
   (

    (unfold-single-defined-constant (0) comb)
    (apply-macete factorial-out)
    simplify
    (unfold-single-defined-constant (0) factorial)
    (unfold-single-defined-constant (0) prod)
    simplify

    )))

(def-theorem comb-m-value-lemma
  "forall(m:zz, comb(m,m)=1)"
  (theory h-o-real-arithmetic)
  (proof
   (

    (unfold-single-defined-constant (0) comb)
    simplify
    (unfold-single-defined-constant (0) factorial)
    (unfold-single-defined-constant (0) prod)
    simplify

    )))

;;Easy:

(def-theorem comb-definedness-lemma
  "forall(m,k:zz,#(comb(m,k)))"
  (theory h-o-real-arithmetic)
  (proof
   (

    insistent-direct-inference
    unfold-defined-constants
    simplify

    ))
  (usages d-r-convergence))

;;;(def-theorem factorial-triviality
;;;  "forall(p:zz,p<=0 implies p!=1)"
;;;  (theory h-o-real-arithmetic)
;;;  (proof
;;;   (
;;;    (unfold-single-defined-constant (0) factorial)
;;;    (unfold-single-defined-constant (0) prod)
;;;    simplify
;;;
;;;    )))

(def-theorem comb-integrality-lemma
  "forall(m,k:zz,k<=m and 0<=k implies #(comb(m,k),zz))"
  (theory h-o-real-arithmetic)
  (usages d-r-convergence)
  (proof
   (

    (cut-with-single-formula "forall(m:zz,0<=m implies forall(k,p:zz,0<=k and k<=p and p<=m implies #(comb(p,k),zz)))")
    direct-and-antecedent-inference-strategy
    (backchain "forall(m:zz,
  0<=m
   implies 
  forall(k,p:zz,
    0<=k and k<=p and p<=m implies #(comb(p,k),zz)));")
    (instantiate-existential ("m"))
    simplify
    simplify
    (induction trivial-integer-inductor ())
    beta-reduce-repeatedly
    direct-and-antecedent-inference-strategy
    (cut-with-single-formula "k=0 and p=0")
    simplify
    (apply-macete-with-minor-premises comb-0-value-lemma)
    simplify
    (case-split ("p<=t"))
    (backchain "with(t:zz,
  forall(k,p:zz,
    0<=k and k<=p and p<=t implies #(comb(p,k),zz)));")
    direct-and-antecedent-inference-strategy
    (case-split ("k=0"))
    (backchain "with(k:zz,k=0);")
    (apply-macete-with-minor-premises comb-0-value-lemma)
    (case-split ("k=p"))
    (backchain "with(p,k:zz,k=p);")
    (apply-macete-with-minor-premises comb-m-value-lemma)
    (force-substitution "p" "1+(p-1)" (0))
    (apply-macete-with-minor-premises comb-ident)
    sort-definedness
    (backchain "with(t:zz,
  forall(k,p:zz,
    0<=k and k<=p and p<=t implies #(comb(p,k),zz)));")
    simplify
    (backchain "with(t:zz,
  forall(k,p:zz,
    0<=k and k<=p and p<=t implies #(comb(p,k),zz)));")
    simplify
    simplify

    )))

(def-theorem generalized-combinatorial-identity
  "forall(k,n:zz,
     0<=k and 1<=n
      implies 
     sum(0,k,lambda(j:zz,comb(n+j,j)))=comb(n+k+1,k))"
  (theory h-o-real-arithmetic)
  (proof
   (

    (induction trivial-integer-inductor ())
    beta-reduce-repeatedly
    (unfold-single-defined-constant (0) sum)
    (apply-macete-with-minor-premises comb-0-value-lemma)
    simplify
    (unfold-single-defined-constant (0) sum)
    simplify
    (force-substitution "2+n+t" "1+(1+n+t)" (0))
    (apply-macete-with-minor-premises comb-ident)
    simplify
    simplify

    )))
