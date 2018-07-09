require "thor"

class Lono::Cfn < Lono::Command
  autoload :AwsService, 'lono/cfn/aws_service'
  autoload :Util, 'lono/cfn/util'
  autoload :CLI, 'lono/cfn/cli'
  autoload :Base, 'lono/cfn/base'
  autoload :Create, 'lono/cfn/create'
  autoload :Update, 'lono/cfn/update'
  autoload :Delete, 'lono/cfn/delete'
  autoload :Preview, 'lono/cfn/preview'
  autoload :Diff, 'lono/cfn/diff'
  autoload :Download, 'lono/cfn/download'
  autoload :Status, 'lono/cfn/status'

  class_option :verbose, type: :boolean
  class_option :noop, type: :boolean

  # common to create and update
  class_option :template, desc: "override convention and specify the template file to use"
  class_option :param, desc: "override convention and specify the param file to use"
  class_option :lono, type: :boolean, desc: "invoke lono to generate CloudFormation templates", default: true
  class_option :capabilities, type: :array, desc: "iam capabilities. Ex: CAPABILITY_IAM, CAPABILITY_NAMED_IAM"
  class_option :iam, type: :boolean, desc: "Shortcut for common IAM capabilities: CAPABILITY_IAM, CAPABILITY_NAMED_IAM"
  class_option :rollback, type: :boolean, desc: "rollback", default: true

  wait_option = Proc.new do
    option :wait, type: :boolean, desc: "Wait for stack operation to complete.", default: true
  end

  desc "create STACK", "Create a CloudFormation stack using the generated template."
  option :randomize_stack_name, type: :boolean, desc: "tack on random string at the end of the stack name", default: nil
  wait_option.call
  long_desc Lono::Help.text("cfn/create")
  def create(name)
    Create.new(name, options).run
  end

  desc "update STACK", "Update a CloudFormation stack using the generated template."
  long_desc Lono::Help.text("cfn/update")
  option :change_set, type: :boolean, default: true, desc: "Uses generated change set to update the stack.  If false, will perform normal update-stack."
  option :diff, type: :boolean, default: true, desc: "Show diff of the source code template changes before continuing."
  option :preview, type: :boolean, default: true, desc: "Show preview of the stack changes before continuing."
  option :sure, type: :boolean, desc: "Skips are you sure prompt"
  wait_option.call
  def update(name)
    Update.new(name, options).run
  end

  desc "delete STACK", "Delete a CloudFormation stack."
  long_desc Lono::Help.text("cfn/delete")
  option :sure, type: :boolean, desc: "Skips are you sure prompt"
  wait_option.call
  def delete(name)
    Delete.new(name, options).run
  end

  desc "preview STACK", "Preview a CloudFormation stack update.  This is similar to terraform's plan or puppet's dry-run mode."
  long_desc Lono::Help.text("cfn/preview")
  option :keep, type: :boolean, desc: "keep the changeset instead of deleting it afterwards"
  option :diff, type: :boolean, default: true, desc: "Show diff of the source code template changes also."
  def preview(name)
    Diff.new(name, options).run if options[:diff]
    Preview.new(name, options).run
  end

  desc "diff STACK", "Diff newly generated template vs existing template."
  long_desc Lono::Help.text("cfn/diff")
  def diff(name)
    Diff.new(name, options).run
  end

  desc "download STACK", "Download CloudFormation template from existing stack."
  long_desc Lono::Help.text("cfn/download")
  option :name, desc: "Name you want to save the template as. Default: existing stack name."
  def download(stack_name)
    Download.new(stack_name, options).run
  end
end
