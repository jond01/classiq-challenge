namespace ClassiqChallenge {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    // Programs for the MCX gate

    operation MultiControlledX(ctrlRegister : Qubit[], target : Qubit) : Unit is Adj + Ctl {
        // Simple implementation of the Multi-Controlled X gate
        Controlled X(ctrlRegister, target);
    }
    
    @EntryPoint()
    operation ApplyMultiControlledX(initControl : Bool, initTarget : Bool) : Result {
        let ctrlRegisterSize = 14;
        let auxRegisterSize = 5;
        // Allocate the qubits. The auxiliary qubits `auxRegister` are currently unused.
        use (ctrlRegister, target, auxRegister) = (
            Qubit[ctrlRegisterSize], Qubit(), Qubit[auxRegisterSize]
        );
        if initTarget {
            X(target);
        }
        // Apply X gates to the control qubits inside a `within` statement to leave these
        // qubits clean (free back to zero)
        within {
            if initControl {
                ApplyToEachCA(X, ctrlRegister);
            }
        }
        apply {
            MultiControlledX(ctrlRegister, target);
        }
        return M(target);
    }

}
