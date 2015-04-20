## Using the --query Option
Careful readers may have noticed the `"--query"` option used in the command line snippets during the ec2 exercise. The `query` option allows selection of output based on a "JMESPath." Don't worry about the complexity of this - if you look at the output of a command (say, `aws ec2 describe-instances --region us-west-2`) you'll be able to quickly piece together the required parameters for returning the data you are after.

Further instructions for use are here: http://docs.aws.amazon.com/cli/latest/userguide/controlling-output.html.
