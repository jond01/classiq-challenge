using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.Quantum.Simulation.Simulators.QCTraceSimulators;
using TestTraceSimulator;

namespace host
{
    static class Program
    {
        static int DefaultPrimitiveDepth = 1;

        // See:
        // https://docs.microsoft.com/en-us/dotnet/api/microsoft.quantum.simulation.simulators.qctracesimulators.qctracesimulatorconfiguration
        static QCTraceSimulatorConfiguration GetConfig(bool tDepth = false)
        {
            var config = new QCTraceSimulatorConfiguration();
            config.UseWidthCounter = true;
            config.UseDepthCounter = true;

            // Optimize for minimal depth
            config.OptimizeDepth = true;

            // Configure depth counting:
            // Count every relevant primitive in the depth metric.
            // By default only T primitives are counted, i.e. the depth is T-depth.
            if (!tDepth)
            {
                foreach (var primitive in Enum.GetNames<PrimitiveOperationsGroups>())
                {
                    config.TraceGateTimes[Enum.Parse<PrimitiveOperationsGroups>(primitive)] =
                    DefaultPrimitiveDepth;
                }
            }

            Console.WriteLine("Primitives depth:");
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
            var tDepth = false;

            if (args.Length > 0)
            {
                tDepth = args[0] == "--t-depth";
            }

            var config = GetConfig(tDepth: tDepth);
            var simOriginal = new QCTraceSimulator(config);
            var simNonOriginal = new QCTraceSimulator(config);

            await Task.WhenAll(
                TestCCNOT.Run(simOriginal, original: true),
                TestCCNOT.Run(simNonOriginal, original: false)
            );

            foreach (var sim in new List<QCTraceSimulator> { simOriginal, simNonOriginal })
            {
                double depth = sim.GetMetric<TestCCNOT>(MetricsNames.DepthCounter.Depth);
                double width = sim.GetMetric<TestCCNOT>(MetricsNames.WidthCounter.ExtraWidth);
                Console.WriteLine(sim.Name);
                Console.WriteLine($"Depth: {depth}, width: {width}.");
            }
        }
    }
}
