using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.Quantum.Simulation.Simulators.QCTraceSimulators;
using ClassiqChallenge;

namespace host
{
    static class Program
    {
        static int DefaultPrimitiveDepth = 1;

        // See:
        // https://docs.microsoft.com/en-us/dotnet/api/microsoft.quantum.simulation.simulators.qctracesimulators.qctracesimulatorconfiguration
        static QCTraceSimulatorConfiguration GetConfig()
        {
            var config = new QCTraceSimulatorConfiguration();
            config.UseWidthCounter = true;
            config.UseDepthCounter = true;

            // Optimize for using less qubits
            config.OptimizeDepth = false;

            // Configure depth counting:
            // Count every relevant primitive in the depth metric.
            // By default only T primitives are counted, i.e. the depth is T-depth.
            foreach (var primitive in new List<PrimitiveOperationsGroups>{
                PrimitiveOperationsGroups.CNOT,
                PrimitiveOperationsGroups.QubitClifford,
                PrimitiveOperationsGroups.R,
                PrimitiveOperationsGroups.T,
                }
            )
            {
                config.TraceGateTimes[primitive] = DefaultPrimitiveDepth;
            }
            // Do not count measurements - they are only helpers in this case.
            config.TraceGateTimes[PrimitiveOperationsGroups.Measure] = 0;

            foreach (var kvp in config.TraceGateTimes)
            {
                Console.WriteLine(kvp);
            }
            return config;
        }

        // See:
        // https://docs.microsoft.com/en-us/azure/quantum/machines/qc-trace-simulator/width-counter
        static async Task Main(string[] args)
        {
            var sim = new QCTraceSimulator(GetConfig());

            var singleQubitResult = await ApplyMultiControlledX.Run(
                sim, initControl: false, initTarget: false
            );

            double width = sim.GetMetric<ApplyMultiControlledX>(MetricsNames.WidthCounter.ExtraWidth);
            double depth = sim.GetMetric<ApplyMultiControlledX>(MetricsNames.DepthCounter.Depth);

            Console.WriteLine($"Single qubit result: {singleQubitResult}");
            Console.WriteLine($"Width: {width}, Depth: {depth}.");
        }
    }
}
