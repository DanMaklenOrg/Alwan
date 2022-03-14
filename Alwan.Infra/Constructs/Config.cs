namespace Alwan.Infra.Constructs;

using Amazon.CDK;

internal readonly struct Config
{
    internal string Name { get; private init; }

    internal string DomainName { get; private init; }

    internal string CertificateArn { get; private init; }

    internal static Config FromContext(App app)
    {
        return new Config
        {
            Name = Convert.ToString(app.Node.TryGetContext("Name")) ?? string.Empty,
            CertificateArn = Convert.ToString(app.Node.TryGetContext("CertificateArn")) ?? string.Empty,
            DomainName = Convert.ToString(app.Node.TryGetContext("DomainName")) ?? string.Empty,
        };
    }
}
