require 'spec_helper'

describe SCSSLint::Reporter::FilesReporter do
  subject { described_class.new(lints) }

  describe '#report_lints' do
    context 'when there are no lints' do
      let(:lints) { [] }

      it 'returns nil' do
        subject.report_lints.should be_nil
      end
    end

    context 'when there are lints' do
      let(:filenames)    { ['some-filename.scss', 'some-filename.scss', 'other-filename.scss'] }
      let(:lints) do
        filenames.each_with_index.map do |filename, index|
          SCSSLint::Lint.new(filename, 0, '', :warning)
        end
      end

      it 'prints each file on its own line' do
        subject.report_lints.count("\n").should == 2
      end

      it 'prints a trailing newline' do
        subject.report_lints[-1].should == "\n"
      end

      it 'prints the filename for each lint' do
        filenames.each do |filename|
          subject.report_lints.scan(/#{filename}/).count.should == 1
        end
      end
    end
  end
end
