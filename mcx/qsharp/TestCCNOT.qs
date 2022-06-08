namespace TestTraceSimulator {
    open Microsoft.Quantum.Intrinsic;

    // See:
    // https://github.com/microsoft/qsharp-runtime/blob/1761b379397520c0fa10ec8d2592f1df2b1acecf/src/Simulation/TargetDefinitions/Decompositions/CCNOTFromCCZ.qs#L22-L31
    operation CCNOTFromCCZ(control1 : Qubit, control2 : Qubit, target : Qubit) : Unit {
        within {
            H(target);
        }
        // The internal `CCZ` operation:
        // https://github.com/microsoft/qsharp-runtime/blob/1761b379397520c0fa10ec8d2592f1df2b1acecf/src/Simulation/TargetDefinitions/Decompositions/Utils.qs#L101-L116
        apply {
            Adjoint T(control1);
            Adjoint T(control2);
            CNOT(target, control1);
            T(control1);
            CNOT(control2, target);
            CNOT(control2, control1);
            T(target);
            Adjoint T(control1);
            CNOT(control2, target);
            CNOT(target, control1);
            Adjoint T(target);
            T(control1);
            CNOT(control2, control1);
        }
    }

    operation TestCCNOT(original : Bool) : Unit {
        use (control1, control2, target) = (Qubit(), Qubit(), Qubit());
        if original {
            CCNOT(control1, control2, target);
        }
        else {
            CCNOTFromCCZ(control1, control2, target);
        }
    }

}
