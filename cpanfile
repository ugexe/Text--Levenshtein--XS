requires "Exporter" => "0";
requires "XSLoader" => "0";
requires "perl" => "5.008";
requires "strict" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Spec" => "0";
  requires "Test::More" => "0";
  requires "utf8" => "0";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "Dist::Zilla" => "5";
  requires "Dist::Zilla::Plugin::Authority" => "0";
  requires "Dist::Zilla::Plugin::AutoPrereqs" => "0";
  requires "Dist::Zilla::Plugin::BumpVersionAfterRelease" => "0";
  requires "Dist::Zilla::Plugin::CPANFile" => "0";
  requires "Dist::Zilla::Plugin::CheckChangesHasContent" => "0";
  requires "Dist::Zilla::Plugin::CheckMetaResources" => "0";
  requires "Dist::Zilla::Plugin::CheckPrereqsIndexed" => "0";
  requires "Dist::Zilla::Plugin::ConfirmRelease" => "0";
  requires "Dist::Zilla::Plugin::CopyFilesFromBuild" => "0";
  requires "Dist::Zilla::Plugin::Git::Check" => "0";
  requires "Dist::Zilla::Plugin::Git::CheckFor::CorrectBranch" => "0";
  requires "Dist::Zilla::Plugin::Git::Commit" => "0";
  requires "Dist::Zilla::Plugin::Git::CommitBuild" => "0";
  requires "Dist::Zilla::Plugin::Git::Contributors" => "0";
  requires "Dist::Zilla::Plugin::Git::GatherDir" => "0";
  requires "Dist::Zilla::Plugin::Git::Push" => "0";
  requires "Dist::Zilla::Plugin::Git::Tag" => "0";
  requires "Dist::Zilla::Plugin::GithubMeta" => "0";
  requires "Dist::Zilla::Plugin::InsertCopyright" => "0";
  requires "Dist::Zilla::Plugin::License" => "0";
  requires "Dist::Zilla::Plugin::MakeMaker" => "0";
  requires "Dist::Zilla::Plugin::Manifest" => "0";
  requires "Dist::Zilla::Plugin::MetaJSON" => "0";
  requires "Dist::Zilla::Plugin::MetaNoIndex" => "0";
  requires "Dist::Zilla::Plugin::MetaProvides::Package" => "0";
  requires "Dist::Zilla::Plugin::MetaTests" => "0";
  requires "Dist::Zilla::Plugin::MetaYAML" => "0";
  requires "Dist::Zilla::Plugin::MinimumPerl" => "0";
  requires "Dist::Zilla::Plugin::NextRelease" => "0";
  requires "Dist::Zilla::Plugin::PodCoverageTests" => "0";
  requires "Dist::Zilla::Plugin::PodSyntaxTests" => "0";
  requires "Dist::Zilla::Plugin::PodWeaver" => "0";
  requires "Dist::Zilla::Plugin::Prereqs::AuthorDeps" => "0";
  requires "Dist::Zilla::Plugin::PromptIfStale" => "0";
  requires "Dist::Zilla::Plugin::PruneCruft" => "0";
  requires "Dist::Zilla::Plugin::ReadmeFromPod" => "0";
  requires "Dist::Zilla::Plugin::RewriteVersion" => "0";
  requires "Dist::Zilla::Plugin::RunExtraTests" => "0";
  requires "Dist::Zilla::Plugin::Test::Compile" => "0";
  requires "Dist::Zilla::Plugin::Test::MinimumVersion" => "0";
  requires "Dist::Zilla::Plugin::Test::Perl::Critic" => "0";
  requires "Dist::Zilla::Plugin::Test::PodSpelling" => "0";
  requires "Dist::Zilla::Plugin::Test::Portability" => "0";
  requires "Dist::Zilla::Plugin::Test::ReportPrereqs" => "0";
  requires "Dist::Zilla::Plugin::Test::Version" => "0";
  requires "Dist::Zilla::Plugin::TravisYML" => "0";
  requires "File::Spec" => "0";
  requires "File::Temp" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Test::CPAN::Meta" => "0";
  requires "Test::More" => "0";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
  requires "Test::Spelling" => "0.12";
};
