namespace Alwan.Infra.Constructs;

using Amazon.CDK;
using Amazon.CDK.AWS.CertificateManager;
using Amazon.CDK.AWS.CloudFront;
using Amazon.CDK.AWS.CloudFront.Origins;
using Amazon.CDK.AWS.S3;
using global::Constructs;

internal class SinglePageApplicationStack : Stack
{
    public SinglePageApplicationStack(Construct scope, Config config)
        : base(scope, $"{config.Name}-stack", new StackProps
        {
            Description = "Holds the required resources to deploy and publish a single page application (SPA) website.",
            TerminationProtection = true,
        })
    {
        IBucket bucket = new Bucket(this, "hosting-bucket", new BucketProps
        {
            BucketName = $"{config.Name.ToLower()}-hosting-bucket",
            WebsiteIndexDocument = "index.html",
            WebsiteErrorDocument = "index.html",
            PublicReadAccess = true,
            RemovalPolicy = RemovalPolicy.DESTROY,
            AutoDeleteObjects = true,
        });

        ICertificate certificate = Certificate.FromCertificateArn(this, "domainCertificate", config.CertificateArn);

        Distribution edgeDistribution = new Distribution(this, "edgeDistribution", new DistributionProps
        {
            DefaultBehavior = new BehaviorOptions { Origin = new S3Origin(bucket), ViewerProtocolPolicy = ViewerProtocolPolicy.REDIRECT_TO_HTTPS },
            DomainNames = new[] { config.DomainName, $"*.{config.DomainName}" },
            Certificate = certificate,
        });

        CfnOutput _ = new CfnOutput(this, "bucketName", new CfnOutputProps
        {
            ExportName = "bucketName",
            Value = bucket.BucketName,
        });

        CfnOutput __ = new CfnOutput(this, "edgeDistributeEndpoint", new CfnOutputProps
        {
            ExportName = "edgeDistributeEndpoint",
            Value = edgeDistribution.DistributionDomainName,
        });
    }
}
