using Alwan.Infra.Constructs;
using Amazon.CDK;

App app = new App();
Config config = Config.FromContext(app);
Stack _ = new SinglePageApplicationStack(app, config);
app.Synth();