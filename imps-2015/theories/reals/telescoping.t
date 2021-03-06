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


(herald telescoping)

(include-files
  (files (imps theories/algebra/groups-as-monoids)))

(def-theorem 1stnsquares
  "forall(n:zz,
     0<=n implies 
     sum(0,n,lambda(j:zz,j^2))=n*(n+1)*((2*n+1)/6))"
  (theory h-o-real-arithmetic)
  (proof
   (
  
    (cut-with-single-formula "lambda(j:zz,j^2)==delta(lambda(n:zz,(n-1)*n*((2*n-1)/6)))")
    (backchain "with(a,b:[zz,rr], a==b)")
    (apply-macete-with-minor-premises tr%telescoping-prod-formula)
    simplify
    (unfold-single-defined-constant (0) rr%delta)
    simplify
    )))

;;;(def-theorem geometric-series-formula-alternate
;;;  "forall(n:zz,r:rr, not(r=0) and not(r=1) and 0<=n
;;;         implies 
;;;     sum(0,n,lambda(j:zz,r^j))=(1-r^(n+1))/(1-r))"
;;;  (theory h-o-real-arithmetic)
;;;  (proof
;;;   (
;;;  
;;;    (cut-with-single-formula "lambda(j:zz,r^j)==delta(lambda(n:zz,(1-r^n)/(1-r)))")
;;;    (backchain "with(a,b:[zz,rr], a==b)")
;;;    (apply-macete-with-minor-premises tr%telescoping-prod-formula)
;;;    simplify
;;;    (unfold-single-defined-constant (0) rr%delta)
;;;    simplify
;;;    )))
