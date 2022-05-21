
%Range = type { i64, i64, i64 }
%Array = type opaque
%String = type opaque
%Qubit = type opaque
%Result = type opaque
%Tuple = type opaque

@PauliI = internal constant i2 0
@PauliX = internal constant i2 1
@PauliY = internal constant i2 -1
@PauliZ = internal constant i2 -2
@EmptyRange = internal constant %Range { i64 0, i64 1, i64 -1 }
@0 = internal constant [30 x i8] c"The indices must be different\00"
@1 = internal constant [36 x i8] c"Qubit in invalid state. Expecting: \00"
@2 = internal constant [3 x i8] c"()\00"

define internal void @TestExp__TestMyExpZ__body(i64 %numQubits) {
entry:
  %qubits = call %Array* @__quantum__rt__qubit_allocate_array(i64 %numQubits)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  %0 = load i2, i2* @PauliZ, align 1
  %pauliArr = call %Array* @Microsoft__Quantum__Arrays___31dfe13a8fd2488680deeb5c6b2bbdc2_ConstantArray__body(i64 %numQubits, i2 %0)
  call void @__quantum__rt__array_update_alias_count(%Array* %pauliArr, i32 1)
  %1 = call double @Microsoft__Quantum__Math__PI__body()
  %theta = fdiv double %1, 2.000000e+00
  %idx1 = sub i64 %numQubits, 1
  %2 = icmp eq i64 0, %idx1
  br i1 %2, label %then0__1, label %continue__1

then0__1:                                         ; preds = %entry
  %3 = call %String* @__quantum__rt__string_create(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @0, i32 0, i32 0))
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %pauliArr, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %pauliArr, i32 -1)
  call void @__quantum__rt__qubit_release_array(%Array* %qubits)
  call void @__quantum__rt__fail(%String* %3)
  unreachable

continue__1:                                      ; preds = %entry
  %4 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 0)
  %5 = bitcast i8* %4 to %Qubit**
  %qubit = load %Qubit*, %Qubit** %5, align 8
  call void @__quantum__qis__h__body(%Qubit* %qubit)
  %6 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 0)
  %7 = bitcast i8* %6 to %Qubit**
  %8 = load %Qubit*, %Qubit** %7, align 8
  %9 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 %idx1)
  %10 = bitcast i8* %9 to %Qubit**
  %11 = load %Qubit*, %Qubit** %10, align 8
  call void @Microsoft__Quantum__Intrinsic__CNOT__body(%Qubit* %8, %Qubit* %11)
  call void @__quantum__rt__array_update_alias_count(%Array* %pauliArr, i32 1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  call void @__quantum__qis__exp__body(%Array* %pauliArr, double %theta, %Array* %qubits)
  call void @__quantum__rt__array_update_alias_count(%Array* %pauliArr, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  %12 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 0)
  %13 = bitcast i8* %12 to %Qubit**
  %14 = load %Qubit*, %Qubit** %13, align 8
  %15 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 %idx1)
  %16 = bitcast i8* %15 to %Qubit**
  %17 = load %Qubit*, %Qubit** %16, align 8
  call void @Microsoft__Quantum__Intrinsic__CNOT__adj(%Qubit* %14, %Qubit* %17)
  %18 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 0)
  %19 = bitcast i8* %18 to %Qubit**
  %qubit__1 = load %Qubit*, %Qubit** %19, align 8
  call void @__quantum__qis__h__body(%Qubit* %qubit__1)
  %expected = call %Result* @__quantum__rt__result_get_zero()
  %20 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 0)
  %21 = bitcast i8* %20 to %Qubit**
  %22 = load %Qubit*, %Qubit** %21, align 8
  call void @Microsoft__Quantum__Diagnostics__AssertQubit__body(%Result* %expected, %Qubit* %22)
  call void @Microsoft__Quantum__Intrinsic__ResetAll__body(%Array* %qubits)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %pauliArr, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %pauliArr, i32 -1)
  call void @__quantum__rt__qubit_release_array(%Array* %qubits)
  ret void
}

declare %Qubit* @__quantum__rt__qubit_allocate()

declare %Array* @__quantum__rt__qubit_allocate_array(i64)

declare void @__quantum__rt__qubit_release_array(%Array*)

declare void @__quantum__rt__array_update_alias_count(%Array*, i32)

define internal %Array* @Microsoft__Quantum__Arrays___31dfe13a8fd2488680deeb5c6b2bbdc2_ConstantArray__body(i64 %length, i2 %value) {
entry:
  %0 = call %Array* @__quantum__rt__array_create_1d(i32 1, i64 %length)
  %1 = sub i64 %length, 1
  br label %header__1

header__1:                                        ; preds = %exiting__1, %entry
  %2 = phi i64 [ 0, %entry ], [ %6, %exiting__1 ]
  %3 = icmp sle i64 %2, %1
  br i1 %3, label %body__1, label %exit__1

body__1:                                          ; preds = %header__1
  %4 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %0, i64 %2)
  %5 = bitcast i8* %4 to i2*
  store i2 %value, i2* %5, align 1
  br label %exiting__1

exiting__1:                                       ; preds = %body__1
  %6 = add i64 %2, 1
  br label %header__1

exit__1:                                          ; preds = %header__1
  ret %Array* %0
}

define internal double @Microsoft__Quantum__Math__PI__body() {
entry:
  ret double 0x400921FB54442D18
}

declare %String* @__quantum__rt__string_create(i8*)

declare void @__quantum__rt__array_update_reference_count(%Array*, i32)

declare void @__quantum__rt__fail(%String*)

declare i8* @__quantum__rt__array_get_element_ptr_1d(%Array*, i64)

declare void @__quantum__qis__h__body(%Qubit*)

define internal void @Microsoft__Quantum__Intrinsic__CNOT__body(%Qubit* %control, %Qubit* %target) {
entry:
  %__controlQubits__ = call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %0 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %__controlQubits__, i64 0)
  %1 = bitcast i8* %0 to %Qubit**
  store %Qubit* %control, %Qubit** %1, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  call void @__quantum__qis__x__ctl(%Array* %__controlQubits__, %Qubit* %target)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %__controlQubits__, i32 -1)
  ret void
}

declare void @__quantum__qis__exp__body(%Array*, double, %Array*)

define internal void @Microsoft__Quantum__Intrinsic__CNOT__adj(%Qubit* %control, %Qubit* %target) {
entry:
  call void @Microsoft__Quantum__Intrinsic__CNOT__body(%Qubit* %control, %Qubit* %target)
  ret void
}

declare %Result* @__quantum__rt__result_get_zero()

define internal void @Microsoft__Quantum__Diagnostics__AssertQubit__body(%Result* %expected, %Qubit* %q) {
entry:
  %0 = call %Array* @__quantum__rt__array_create_1d(i32 1, i64 1)
  %1 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %0, i64 0)
  %2 = bitcast i8* %1 to i2*
  %3 = load i2, i2* @PauliZ, align 1
  store i2 %3, i2* %2, align 1
  %4 = call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %5 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %4, i64 0)
  %6 = bitcast i8* %5 to %Qubit**
  store %Qubit* %q, %Qubit** %6, align 8
  %7 = call %String* @__quantum__rt__string_create(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @1, i32 0, i32 0))
  %8 = call %String* @__quantum__rt__result_to_string(%Result* %expected)
  %9 = call %String* @__quantum__rt__string_concatenate(%String* %7, %String* %8)
  call void @__quantum__rt__string_update_reference_count(%String* %7, i32 -1)
  call void @__quantum__rt__string_update_reference_count(%String* %8, i32 -1)
  call void @Microsoft__Quantum__Diagnostics__AssertMeasurement__body(%Array* %0, %Array* %4, %Result* %expected, %String* %9)
  call void @__quantum__rt__array_update_reference_count(%Array* %0, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %4, i32 -1)
  call void @__quantum__rt__string_update_reference_count(%String* %9, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__ResetAll__body(%Array* %qubits) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  %0 = call i64 @__quantum__rt__array_get_size_1d(%Array* %qubits)
  %1 = sub i64 %0, 1
  br label %header__1

header__1:                                        ; preds = %exiting__1, %entry
  %2 = phi i64 [ 0, %entry ], [ %6, %exiting__1 ]
  %3 = icmp sle i64 %2, %1
  br i1 %3, label %body__1, label %exit__1

body__1:                                          ; preds = %header__1
  %4 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 %2)
  %5 = bitcast i8* %4 to %Qubit**
  %qubit = load %Qubit*, %Qubit** %5, align 8
  call void @Microsoft__Quantum__Intrinsic__Reset__body(%Qubit* %qubit)
  br label %exiting__1

exiting__1:                                       ; preds = %body__1
  %6 = add i64 %2, 1
  br label %header__1

exit__1:                                          ; preds = %header__1
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Diagnostics__AssertMeasurement__body(%Array* %bases, %Array* %qubits, %Result* %result, %String* %msg) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  call void @__quantum__qis__assertmeasurementprobability__body(%Array* %bases, %Array* %qubits, %Result* %result, double 1.000000e+00, %String* %msg, double 1.000000e-10)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  ret void
}

declare void @__quantum__qis__assertmeasurementprobability__body(%Array*, %Array*, %Result*, double, %String*, double)

define internal void @Microsoft__Quantum__Diagnostics__AssertMeasurement__adj(%Array* %bases, %Array* %qubits, %Result* %result, %String* %msg) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  call void @Microsoft__Quantum__Diagnostics__AssertMeasurement__body(%Array* %bases, %Array* %qubits, %Result* %result, %String* %msg)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Diagnostics__AssertMeasurement__ctl(%Array* %controllingQubits, { %Array*, %Array*, %Result*, %String* }* %0) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %controllingQubits, i32 1)
  %1 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %0, i32 0, i32 0
  %bases = load %Array*, %Array** %1, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 1)
  %2 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %0, i32 0, i32 1
  %qubits = load %Array*, %Array** %2, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  %3 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %0, i32 0, i32 2
  %result = load %Result*, %Result** %3, align 8
  %4 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %0, i32 0, i32 3
  %msg = load %String*, %String** %4, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %controllingQubits, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Diagnostics__AssertMeasurement__ctladj(%Array* %__controlQubits__, { %Array*, %Array*, %Result*, %String* }* %0) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  %1 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %0, i32 0, i32 0
  %bases = load %Array*, %Array** %1, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 1)
  %2 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %0, i32 0, i32 1
  %qubits = load %Array*, %Array** %2, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  %3 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %0, i32 0, i32 2
  %result = load %Result*, %Result** %3, align 8
  %4 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %0, i32 0, i32 3
  %msg = load %String*, %String** %4, align 8
  %5 = call %Tuple* @__quantum__rt__tuple_create(i64 ptrtoint ({ %Array*, %Array*, %Result*, %String* }* getelementptr ({ %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* null, i32 1) to i64))
  %6 = bitcast %Tuple* %5 to { %Array*, %Array*, %Result*, %String* }*
  %7 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %6, i32 0, i32 0
  %8 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %6, i32 0, i32 1
  %9 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %6, i32 0, i32 2
  %10 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %6, i32 0, i32 3
  call void @__quantum__rt__array_update_reference_count(%Array* %bases, i32 1)
  call void @__quantum__rt__array_update_reference_count(%Array* %qubits, i32 1)
  call void @__quantum__rt__result_update_reference_count(%Result* %result, i32 1)
  call void @__quantum__rt__string_update_reference_count(%String* %msg, i32 1)
  store %Array* %bases, %Array** %7, align 8
  store %Array* %qubits, %Array** %8, align 8
  store %Result* %result, %Result** %9, align 8
  store %String* %msg, %String** %10, align 8
  call void @Microsoft__Quantum__Diagnostics__AssertMeasurement__ctl(%Array* %__controlQubits__, { %Array*, %Array*, %Result*, %String* }* %6)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__result_update_reference_count(%Result* %result, i32 -1)
  call void @__quantum__rt__string_update_reference_count(%String* %msg, i32 -1)
  call void @__quantum__rt__tuple_update_reference_count(%Tuple* %5, i32 -1)
  ret void
}

declare %Tuple* @__quantum__rt__tuple_create(i64)

declare void @__quantum__rt__result_update_reference_count(%Result*, i32)

declare void @__quantum__rt__string_update_reference_count(%String*, i32)

declare void @__quantum__rt__tuple_update_reference_count(%Tuple*, i32)

define internal void @Microsoft__Quantum__Diagnostics__AssertMeasurementProbability__body(%Array* %bases, %Array* %qubits, %Result* %result, double %prob, %String* %msg, double %tolerance) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  call void @__quantum__qis__assertmeasurementprobability__body(%Array* %bases, %Array* %qubits, %Result* %result, double %prob, %String* %msg, double %tolerance)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Diagnostics__AssertMeasurementProbability__adj(%Array* %bases, %Array* %qubits, %Result* %result, double %prob, %String* %msg, double %tolerance) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  call void @__quantum__qis__assertmeasurementprobability__body(%Array* %bases, %Array* %qubits, %Result* %result, double %prob, %String* %msg, double %tolerance)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Diagnostics__AssertMeasurementProbability__ctl(%Array* %__controlQubits__, { %Array*, %Array*, %Result*, double, %String*, double }* %0) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  %1 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 0
  %bases = load %Array*, %Array** %1, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 1)
  %2 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 1
  %qubits = load %Array*, %Array** %2, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  %3 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 2
  %result = load %Result*, %Result** %3, align 8
  %4 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 3
  %prob = load double, double* %4, align 8
  %5 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 4
  %msg = load %String*, %String** %5, align 8
  %6 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 5
  %tolerance = load double, double* %6, align 8
  %7 = call %Tuple* @__quantum__rt__tuple_create(i64 ptrtoint ({ %Array*, %Array*, %Result*, double, %String*, double }* getelementptr ({ %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* null, i32 1) to i64))
  %8 = bitcast %Tuple* %7 to { %Array*, %Array*, %Result*, double, %String*, double }*
  %9 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 0
  %10 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 1
  %11 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 2
  %12 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 3
  %13 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 4
  %14 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 5
  call void @__quantum__rt__array_update_reference_count(%Array* %bases, i32 1)
  call void @__quantum__rt__array_update_reference_count(%Array* %qubits, i32 1)
  call void @__quantum__rt__result_update_reference_count(%Result* %result, i32 1)
  call void @__quantum__rt__string_update_reference_count(%String* %msg, i32 1)
  store %Array* %bases, %Array** %9, align 8
  store %Array* %qubits, %Array** %10, align 8
  store %Result* %result, %Result** %11, align 8
  store double %prob, double* %12, align 8
  store %String* %msg, %String** %13, align 8
  store double %tolerance, double* %14, align 8
  call void @__quantum__qis__assertmeasurementprobability__ctl(%Array* %__controlQubits__, { %Array*, %Array*, %Result*, double, %String*, double }* %8)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__result_update_reference_count(%Result* %result, i32 -1)
  call void @__quantum__rt__string_update_reference_count(%String* %msg, i32 -1)
  call void @__quantum__rt__tuple_update_reference_count(%Tuple* %7, i32 -1)
  ret void
}

declare void @__quantum__qis__assertmeasurementprobability__ctl(%Array*, { %Array*, %Array*, %Result*, double, %String*, double }*)

define internal void @Microsoft__Quantum__Diagnostics__AssertMeasurementProbability__ctladj(%Array* %__controlQubits__, { %Array*, %Array*, %Result*, double, %String*, double }* %0) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  %1 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 0
  %bases = load %Array*, %Array** %1, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 1)
  %2 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 1
  %qubits = load %Array*, %Array** %2, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  %3 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 2
  %result = load %Result*, %Result** %3, align 8
  %4 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 3
  %prob = load double, double* %4, align 8
  %5 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 4
  %msg = load %String*, %String** %5, align 8
  %6 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %0, i32 0, i32 5
  %tolerance = load double, double* %6, align 8
  %7 = call %Tuple* @__quantum__rt__tuple_create(i64 ptrtoint ({ %Array*, %Array*, %Result*, double, %String*, double }* getelementptr ({ %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* null, i32 1) to i64))
  %8 = bitcast %Tuple* %7 to { %Array*, %Array*, %Result*, double, %String*, double }*
  %9 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 0
  %10 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 1
  %11 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 2
  %12 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 3
  %13 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 4
  %14 = getelementptr inbounds { %Array*, %Array*, %Result*, double, %String*, double }, { %Array*, %Array*, %Result*, double, %String*, double }* %8, i32 0, i32 5
  call void @__quantum__rt__array_update_reference_count(%Array* %bases, i32 1)
  call void @__quantum__rt__array_update_reference_count(%Array* %qubits, i32 1)
  call void @__quantum__rt__result_update_reference_count(%Result* %result, i32 1)
  call void @__quantum__rt__string_update_reference_count(%String* %msg, i32 1)
  store %Array* %bases, %Array** %9, align 8
  store %Array* %qubits, %Array** %10, align 8
  store %Result* %result, %Result** %11, align 8
  store double %prob, double* %12, align 8
  store %String* %msg, %String** %13, align 8
  store double %tolerance, double* %14, align 8
  call void @__quantum__qis__assertmeasurementprobability__ctl(%Array* %__controlQubits__, { %Array*, %Array*, %Result*, double, %String*, double }* %8)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__result_update_reference_count(%Result* %result, i32 -1)
  call void @__quantum__rt__string_update_reference_count(%String* %msg, i32 -1)
  call void @__quantum__rt__tuple_update_reference_count(%Tuple* %7, i32 -1)
  ret void
}

declare %Array* @__quantum__rt__array_create_1d(i32, i64)

declare %String* @__quantum__rt__result_to_string(%Result*)

declare %String* @__quantum__rt__string_concatenate(%String*, %String*)

define internal void @Microsoft__Quantum__Diagnostics__AssertQubit__adj(%Result* %expected, %Qubit* %q) {
entry:
  %0 = call %Array* @__quantum__rt__array_create_1d(i32 1, i64 1)
  %1 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %0, i64 0)
  %2 = bitcast i8* %1 to i2*
  %3 = load i2, i2* @PauliZ, align 1
  store i2 %3, i2* %2, align 1
  %4 = call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %5 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %4, i64 0)
  %6 = bitcast i8* %5 to %Qubit**
  store %Qubit* %q, %Qubit** %6, align 8
  %7 = call %String* @__quantum__rt__string_create(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @1, i32 0, i32 0))
  %8 = call %String* @__quantum__rt__result_to_string(%Result* %expected)
  %9 = call %String* @__quantum__rt__string_concatenate(%String* %7, %String* %8)
  call void @__quantum__rt__string_update_reference_count(%String* %7, i32 -1)
  call void @__quantum__rt__string_update_reference_count(%String* %8, i32 -1)
  call void @Microsoft__Quantum__Diagnostics__AssertMeasurement__adj(%Array* %0, %Array* %4, %Result* %expected, %String* %9)
  call void @__quantum__rt__array_update_reference_count(%Array* %0, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %4, i32 -1)
  call void @__quantum__rt__string_update_reference_count(%String* %9, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Diagnostics__AssertQubit__ctl(%Array* %__controlQubits__, { %Result*, %Qubit* }* %0) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  %1 = getelementptr inbounds { %Result*, %Qubit* }, { %Result*, %Qubit* }* %0, i32 0, i32 0
  %expected = load %Result*, %Result** %1, align 8
  %2 = getelementptr inbounds { %Result*, %Qubit* }, { %Result*, %Qubit* }* %0, i32 0, i32 1
  %q = load %Qubit*, %Qubit** %2, align 8
  %3 = call %Tuple* @__quantum__rt__tuple_create(i64 ptrtoint ({ %Array*, %Array*, %Result*, %String* }* getelementptr ({ %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* null, i32 1) to i64))
  %4 = bitcast %Tuple* %3 to { %Array*, %Array*, %Result*, %String* }*
  %5 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %4, i32 0, i32 0
  %6 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %4, i32 0, i32 1
  %7 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %4, i32 0, i32 2
  %8 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %4, i32 0, i32 3
  %9 = call %Array* @__quantum__rt__array_create_1d(i32 1, i64 1)
  %10 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %9, i64 0)
  %11 = bitcast i8* %10 to i2*
  %12 = load i2, i2* @PauliZ, align 1
  store i2 %12, i2* %11, align 1
  %13 = call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %14 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %13, i64 0)
  %15 = bitcast i8* %14 to %Qubit**
  store %Qubit* %q, %Qubit** %15, align 8
  call void @__quantum__rt__result_update_reference_count(%Result* %expected, i32 1)
  %16 = call %String* @__quantum__rt__string_create(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @1, i32 0, i32 0))
  %17 = call %String* @__quantum__rt__result_to_string(%Result* %expected)
  %18 = call %String* @__quantum__rt__string_concatenate(%String* %16, %String* %17)
  call void @__quantum__rt__string_update_reference_count(%String* %16, i32 -1)
  call void @__quantum__rt__string_update_reference_count(%String* %17, i32 -1)
  store %Array* %9, %Array** %5, align 8
  store %Array* %13, %Array** %6, align 8
  store %Result* %expected, %Result** %7, align 8
  store %String* %18, %String** %8, align 8
  call void @Microsoft__Quantum__Diagnostics__AssertMeasurement__ctl(%Array* %__controlQubits__, { %Array*, %Array*, %Result*, %String* }* %4)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %9, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %13, i32 -1)
  call void @__quantum__rt__result_update_reference_count(%Result* %expected, i32 -1)
  call void @__quantum__rt__string_update_reference_count(%String* %18, i32 -1)
  call void @__quantum__rt__tuple_update_reference_count(%Tuple* %3, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Diagnostics__AssertQubit__ctladj(%Array* %__controlQubits__, { %Result*, %Qubit* }* %0) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  %1 = getelementptr inbounds { %Result*, %Qubit* }, { %Result*, %Qubit* }* %0, i32 0, i32 0
  %expected = load %Result*, %Result** %1, align 8
  %2 = getelementptr inbounds { %Result*, %Qubit* }, { %Result*, %Qubit* }* %0, i32 0, i32 1
  %q = load %Qubit*, %Qubit** %2, align 8
  %3 = call %Tuple* @__quantum__rt__tuple_create(i64 ptrtoint ({ %Array*, %Array*, %Result*, %String* }* getelementptr ({ %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* null, i32 1) to i64))
  %4 = bitcast %Tuple* %3 to { %Array*, %Array*, %Result*, %String* }*
  %5 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %4, i32 0, i32 0
  %6 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %4, i32 0, i32 1
  %7 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %4, i32 0, i32 2
  %8 = getelementptr inbounds { %Array*, %Array*, %Result*, %String* }, { %Array*, %Array*, %Result*, %String* }* %4, i32 0, i32 3
  %9 = call %Array* @__quantum__rt__array_create_1d(i32 1, i64 1)
  %10 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %9, i64 0)
  %11 = bitcast i8* %10 to i2*
  %12 = load i2, i2* @PauliZ, align 1
  store i2 %12, i2* %11, align 1
  %13 = call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %14 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %13, i64 0)
  %15 = bitcast i8* %14 to %Qubit**
  store %Qubit* %q, %Qubit** %15, align 8
  call void @__quantum__rt__result_update_reference_count(%Result* %expected, i32 1)
  %16 = call %String* @__quantum__rt__string_create(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @1, i32 0, i32 0))
  %17 = call %String* @__quantum__rt__result_to_string(%Result* %expected)
  %18 = call %String* @__quantum__rt__string_concatenate(%String* %16, %String* %17)
  call void @__quantum__rt__string_update_reference_count(%String* %16, i32 -1)
  call void @__quantum__rt__string_update_reference_count(%String* %17, i32 -1)
  store %Array* %9, %Array** %5, align 8
  store %Array* %13, %Array** %6, align 8
  store %Result* %expected, %Result** %7, align 8
  store %String* %18, %String** %8, align 8
  call void @Microsoft__Quantum__Diagnostics__AssertMeasurement__ctladj(%Array* %__controlQubits__, { %Array*, %Array*, %Result*, %String* }* %4)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %9, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %13, i32 -1)
  call void @__quantum__rt__result_update_reference_count(%Result* %expected, i32 -1)
  call void @__quantum__rt__string_update_reference_count(%String* %18, i32 -1)
  call void @__quantum__rt__tuple_update_reference_count(%Tuple* %3, i32 -1)
  ret void
}

declare void @__quantum__qis__x__ctl(%Array*, %Qubit*)

define internal void @Microsoft__Quantum__Intrinsic__CNOT__ctl(%Array* %__controlQubits__, { %Qubit*, %Qubit* }* %0) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  %1 = getelementptr inbounds { %Qubit*, %Qubit* }, { %Qubit*, %Qubit* }* %0, i32 0, i32 0
  %control = load %Qubit*, %Qubit** %1, align 8
  %2 = getelementptr inbounds { %Qubit*, %Qubit* }, { %Qubit*, %Qubit* }* %0, i32 0, i32 1
  %target = load %Qubit*, %Qubit** %2, align 8
  %3 = call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %4 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %3, i64 0)
  %5 = bitcast i8* %4 to %Qubit**
  store %Qubit* %control, %Qubit** %5, align 8
  %__controlQubits__1 = call %Array* @__quantum__rt__array_concatenate(%Array* %__controlQubits__, %Array* %3)
  call void @__quantum__rt__array_update_reference_count(%Array* %__controlQubits__1, i32 1)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__1, i32 1)
  call void @__quantum__qis__x__ctl(%Array* %__controlQubits__1, %Qubit* %target)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__1, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %3, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %__controlQubits__1, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %__controlQubits__1, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  ret void
}

declare %Array* @__quantum__rt__array_concatenate(%Array*, %Array*)

define internal void @Microsoft__Quantum__Intrinsic__CNOT__ctladj(%Array* %__controlQubits__, { %Qubit*, %Qubit* }* %0) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  %1 = getelementptr inbounds { %Qubit*, %Qubit* }, { %Qubit*, %Qubit* }* %0, i32 0, i32 0
  %control = load %Qubit*, %Qubit** %1, align 8
  %2 = getelementptr inbounds { %Qubit*, %Qubit* }, { %Qubit*, %Qubit* }* %0, i32 0, i32 1
  %target = load %Qubit*, %Qubit** %2, align 8
  %3 = call %Tuple* @__quantum__rt__tuple_create(i64 ptrtoint ({ %Qubit*, %Qubit* }* getelementptr ({ %Qubit*, %Qubit* }, { %Qubit*, %Qubit* }* null, i32 1) to i64))
  %4 = bitcast %Tuple* %3 to { %Qubit*, %Qubit* }*
  %5 = getelementptr inbounds { %Qubit*, %Qubit* }, { %Qubit*, %Qubit* }* %4, i32 0, i32 0
  %6 = getelementptr inbounds { %Qubit*, %Qubit* }, { %Qubit*, %Qubit* }* %4, i32 0, i32 1
  store %Qubit* %control, %Qubit** %5, align 8
  store %Qubit* %target, %Qubit** %6, align 8
  call void @Microsoft__Quantum__Intrinsic__CNOT__ctl(%Array* %__controlQubits__, { %Qubit*, %Qubit* }* %4)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  call void @__quantum__rt__tuple_update_reference_count(%Tuple* %3, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Exp__body(%Array* %paulis, double %theta, %Array* %qubits) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %paulis, i32 1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  call void @__quantum__qis__exp__body(%Array* %paulis, double %theta, %Array* %qubits)
  call void @__quantum__rt__array_update_alias_count(%Array* %paulis, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__Exp__adj(%Array* %paulis, double %theta, %Array* %qubits) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %paulis, i32 1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  call void @__quantum__qis__exp__adj(%Array* %paulis, double %theta, %Array* %qubits)
  call void @__quantum__rt__array_update_alias_count(%Array* %paulis, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  ret void
}

declare void @__quantum__qis__exp__adj(%Array*, double, %Array*)

define internal void @Microsoft__Quantum__Intrinsic__Exp__ctl(%Array* %__controlQubits__, { %Array*, double, %Array* }* %0) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  %1 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %0, i32 0, i32 0
  %paulis = load %Array*, %Array** %1, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %paulis, i32 1)
  %2 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %0, i32 0, i32 1
  %theta = load double, double* %2, align 8
  %3 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %0, i32 0, i32 2
  %qubits = load %Array*, %Array** %3, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  %4 = call %Tuple* @__quantum__rt__tuple_create(i64 ptrtoint ({ %Array*, double, %Array* }* getelementptr ({ %Array*, double, %Array* }, { %Array*, double, %Array* }* null, i32 1) to i64))
  %5 = bitcast %Tuple* %4 to { %Array*, double, %Array* }*
  %6 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %5, i32 0, i32 0
  %7 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %5, i32 0, i32 1
  %8 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %5, i32 0, i32 2
  call void @__quantum__rt__array_update_reference_count(%Array* %paulis, i32 1)
  call void @__quantum__rt__array_update_reference_count(%Array* %qubits, i32 1)
  store %Array* %paulis, %Array** %6, align 8
  store double %theta, double* %7, align 8
  store %Array* %qubits, %Array** %8, align 8
  call void @__quantum__qis__exp__ctl(%Array* %__controlQubits__, { %Array*, double, %Array* }* %5)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %paulis, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %paulis, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__tuple_update_reference_count(%Tuple* %4, i32 -1)
  ret void
}

declare void @__quantum__qis__exp__ctl(%Array*, { %Array*, double, %Array* }*)

define internal void @Microsoft__Quantum__Intrinsic__Exp__ctladj(%Array* %__controlQubits__, { %Array*, double, %Array* }* %0) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  %1 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %0, i32 0, i32 0
  %paulis = load %Array*, %Array** %1, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %paulis, i32 1)
  %2 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %0, i32 0, i32 1
  %theta = load double, double* %2, align 8
  %3 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %0, i32 0, i32 2
  %qubits = load %Array*, %Array** %3, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  %4 = call %Tuple* @__quantum__rt__tuple_create(i64 ptrtoint ({ %Array*, double, %Array* }* getelementptr ({ %Array*, double, %Array* }, { %Array*, double, %Array* }* null, i32 1) to i64))
  %5 = bitcast %Tuple* %4 to { %Array*, double, %Array* }*
  %6 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %5, i32 0, i32 0
  %7 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %5, i32 0, i32 1
  %8 = getelementptr inbounds { %Array*, double, %Array* }, { %Array*, double, %Array* }* %5, i32 0, i32 2
  call void @__quantum__rt__array_update_reference_count(%Array* %paulis, i32 1)
  call void @__quantum__rt__array_update_reference_count(%Array* %qubits, i32 1)
  store %Array* %paulis, %Array** %6, align 8
  store double %theta, double* %7, align 8
  store %Array* %qubits, %Array** %8, align 8
  call void @__quantum__qis__exp__ctladj(%Array* %__controlQubits__, { %Array*, double, %Array* }* %5)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %paulis, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %paulis, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__tuple_update_reference_count(%Tuple* %4, i32 -1)
  ret void
}

declare void @__quantum__qis__exp__ctladj(%Array*, { %Array*, double, %Array* }*)

define internal void @Microsoft__Quantum__Intrinsic__H__body(%Qubit* %qubit) {
entry:
  call void @__quantum__qis__h__body(%Qubit* %qubit)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__H__adj(%Qubit* %qubit) {
entry:
  call void @__quantum__qis__h__body(%Qubit* %qubit)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__H__ctl(%Array* %__controlQubits__, %Qubit* %qubit) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  call void @__quantum__qis__h__ctl(%Array* %__controlQubits__, %Qubit* %qubit)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  ret void
}

declare void @__quantum__qis__h__ctl(%Array*, %Qubit*)

define internal void @Microsoft__Quantum__Intrinsic__H__ctladj(%Array* %__controlQubits__, %Qubit* %qubit) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  call void @__quantum__qis__h__ctl(%Array* %__controlQubits__, %Qubit* %qubit)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  ret void
}

define internal %Result* @Microsoft__Quantum__Intrinsic__M__body(%Qubit* %qubit) {
entry:
  %bases = call %Array* @__quantum__rt__array_create_1d(i32 1, i64 1)
  %0 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %bases, i64 0)
  %1 = bitcast i8* %0 to i2*
  %2 = load i2, i2* @PauliZ, align 1
  store i2 %2, i2* %1, align 1
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 1)
  %qubits = call %Array* @__quantum__rt__array_create_1d(i32 8, i64 1)
  %3 = call i8* @__quantum__rt__array_get_element_ptr_1d(%Array* %qubits, i64 0)
  %4 = bitcast i8* %3 to %Qubit**
  store %Qubit* %qubit, %Qubit** %4, align 8
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  %5 = call %Result* @__quantum__qis__measure__body(%Array* %bases, %Array* %qubits)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_reference_count(%Array* %qubits, i32 -1)
  ret %Result* %5
}

declare %Result* @__quantum__qis__measure__body(%Array*, %Array*)

define internal %Result* @Microsoft__Quantum__Intrinsic__Measure__body(%Array* %bases, %Array* %qubits) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 1)
  %0 = call %Result* @__quantum__qis__measure__body(%Array* %bases, %Array* %qubits)
  call void @__quantum__rt__array_update_alias_count(%Array* %bases, i32 -1)
  call void @__quantum__rt__array_update_alias_count(%Array* %qubits, i32 -1)
  ret %Result* %0
}

define internal void @Microsoft__Quantum__Intrinsic__Reset__body(%Qubit* %qubit) {
entry:
  %0 = call %Result* @Microsoft__Quantum__Intrinsic__M__body(%Qubit* %qubit)
  %1 = call %Result* @__quantum__rt__result_get_one()
  %2 = call i1 @__quantum__rt__result_equal(%Result* %0, %Result* %1)
  call void @__quantum__rt__result_update_reference_count(%Result* %0, i32 -1)
  br i1 %2, label %then0__1, label %continue__1

then0__1:                                         ; preds = %entry
  call void @__quantum__qis__x__body(%Qubit* %qubit)
  br label %continue__1

continue__1:                                      ; preds = %then0__1, %entry
  ret void
}

declare %Result* @__quantum__rt__result_get_one()

declare i1 @__quantum__rt__result_equal(%Result*, %Result*)

declare void @__quantum__qis__x__body(%Qubit*)

declare i64 @__quantum__rt__array_get_size_1d(%Array*)

define internal void @Microsoft__Quantum__Intrinsic__X__body(%Qubit* %qubit) {
entry:
  call void @__quantum__qis__x__body(%Qubit* %qubit)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__X__adj(%Qubit* %qubit) {
entry:
  call void @__quantum__qis__x__body(%Qubit* %qubit)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__X__ctl(%Array* %__controlQubits__, %Qubit* %qubit) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  call void @__quantum__qis__x__ctl(%Array* %__controlQubits__, %Qubit* %qubit)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  ret void
}

define internal void @Microsoft__Quantum__Intrinsic__X__ctladj(%Array* %__controlQubits__, %Qubit* %qubit) {
entry:
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 1)
  call void @__quantum__qis__x__ctl(%Array* %__controlQubits__, %Qubit* %qubit)
  call void @__quantum__rt__array_update_alias_count(%Array* %__controlQubits__, i32 -1)
  ret void
}

define void @TestExp__TestMyExpZ__Interop(i64 %numQubits) #0 {
entry:
  call void @TestExp__TestMyExpZ__body(i64 %numQubits)
  ret void
}

define void @TestExp__TestMyExpZ(i64 %numQubits) #1 {
entry:
  call void @TestExp__TestMyExpZ__body(i64 %numQubits)
  %0 = call %String* @__quantum__rt__string_create(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @2, i32 0, i32 0))
  call void @__quantum__rt__message(%String* %0)
  call void @__quantum__rt__string_update_reference_count(%String* %0, i32 -1)
  ret void
}

declare void @__quantum__rt__message(%String*)

attributes #0 = { "InteropFriendly" }
attributes #1 = { "EntryPoint" }
