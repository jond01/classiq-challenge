namespace ClassiqChallenge {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;

    // Programs for the MCX gate

    operation MultiControlledX(controlRegister : Qubit[], target : Qubit) :
    Unit is Adj + Ctl {
        // Simple implementation of the Multi-Controlled X gate
        Controlled X(controlRegister, target);
    }

    internal function XOR(a : Bool, b : Bool) : Bool {
        return (a and not b) or (b and not a);
    }

    operation ApplyMultiControlledX(initControl : Bool, initTarget : Bool) :
    Result {
        let controlRegisterSize = 14;
        use (controlRegister, target) = (
            Qubit[controlRegisterSize], Qubit()
        );
        if initTarget {
            X(target);
        }
        // Apply X gates to the control qubits inside a `within` statement
        // to leave these qubits clean (free back to zero)
        within {
            if initControl {
                ApplyToEachCA(X, controlRegister);
            }
        }
        apply {
            MultiControlledX(controlRegister, target);
        }

        let expectedResult = BoolAsResult(XOR(initControl, initTarget));
        AssertQubit(expectedResult, target);

        return M(target);
    }

}
