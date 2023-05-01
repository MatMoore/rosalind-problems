class VerboseReporter
  def initialize(running_single_test:)
    @running_single_test = running_single_test
    @first = true
    @num_failed = 0
    @num_passed = 0
  end

  def report_success(name, output)
    puts "" unless @first
    @first = false
    @num_passed +=1

    puts name unless @running_single_test

    puts output
  end

  def report_fail(name, expected, actual)
    puts "" unless @first
    @first = false
    @num_failed += 1

    puts "#{name} FAILED"
    puts "Expected:"
    puts expected
    puts "--------------------"
    puts "Actual:"
    puts actual
  end

  def report_summary
    puts "--------------------"
    if @num_failed == 0
      puts "OK"
    else
      puts "#{@num_failed} of #{@num_passed} failed."
    end
  end
end


class ConciseReporter < VerboseReporter
  def report_success(_name, _output)
    @num_passed += 1
    print "."
  end

  def report_summary
    if @num_failed == 0
      puts ""
    else
      puts ""
      puts "#{@num_failed} of #{@num_passed + @num_failed} failed."
    end
  end
end
