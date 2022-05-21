namespace TestExp {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Diagnostics;
    
    // A shortened version of the `Exp` operation when all the Paulis are
    // `PauliZ`:
    // https://github.com/microsoft/qsharp-runtime/blob/70c881d8b93f290bca6145fb5fda28e5dbc57827/src/Simulation/TargetDefinitions/Decompositions/ExpFromExpUtil.qs#L25-L40
    operation MyExpZ(theta : Double, qubits : Qubit[]) : Unit is Adj + Ctl {
        body (...) {
                MyExpZUtil(theta , qubits, Rz(-2.0 * theta, _));
            }
        adjoint(...) {
            MyExpZ(-theta, qubits);
        }
    }

    // A shortened version of the internal `ExpUtil` operation:
    // https://github.com/microsoft/qsharp-runtime/blob/70c881d8b93f290bca6145fb5fda28e5dbc57827/src/Simulation/TargetDefinitions/Decompositions/ExpUtil.qs#L18-L23
    // Valid when all `paulis` are `PauliZ` and there are two qubits or more.
    internal operation MyExpZUtil(
        theta : Double, qubits : Qubit[], rotation : ((Qubit) => Unit is Adj + Ctl)
    ) : Unit is Ctl {
        within {
            SpreadZ(qubits[0], qubits[ 1 .. Length(qubits) - 1]);
        }
        apply {
            rotation(qubits[0]);
        }
    }


    // The internal `SpreadZ` operation (verbatim):
    // https://github.com/microsoft/qsharp-runtime/blob/70c881d8b93f290bca6145fb5fda28e5dbc57827/src/Simulation/TargetDefinitions/Decompositions/Utils.qs#L7-L16
    internal operation SpreadZ(from : Qubit, to : Qubit[]) : Unit is Adj {
        if (Length(to) > 0) {
            CNOT(to[0], from);  // <-- The bug. Should appear AFTER the `SpreadZ` calls
            if (Length(to) > 1) {
                let half = Length(to) / 2;
                SpreadZ(to[0], to[half + 1 .. Length(to) - 1]);
                SpreadZ(from, to[1 .. half]);
            }
        }
    }

    @EntryPoint()
    operation TestMyExpZ(numQubits : Int) : Unit {
        // let numQubits = 17;
        use qubits = Qubit[numQubits];
        let pauliArr = ConstantArray<Pauli>(numQubits, PauliZ);
        let theta = PI() / 2.0;
        let (idx0, idx1) = (0, numQubits - 1);
        if idx0 == idx1 { fail "The indices must be different"; }
        within {
            H(qubits[idx0]);
        }
        apply {
            within {
                CNOT(qubits[idx0], qubits[idx1]);
            }
            apply {
                MyExpZ(theta, qubits);
            }
        }
        // let res = M(qubits[idx0]);
        // return res;
        let expected = Zero;
        AssertQubit(expected, qubits[idx0]);
        ResetAll(qubits);
    }

}