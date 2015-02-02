#!/usr/bin/env ruby

def writeindent(of, str, indent)
  # this would be useful if I had the sense to write it
end

def usage
  print "No file given.\nUsage: ./quizgenerator.rb [quizfile.txt]\n"
  exit 0
end

def preamble of, indent
  of.puts ("  " * indent) + "%section#quiz"; indent += 1
  of.puts ("  " * indent) + "%form.row"; indent += 1
  return indent
end

def outQuestion question, qnumber, answers, of, indent
  p "#{indent}\n"
  of.puts ("  " * indent) + ".question#q#{qnumber}"; indent += 1
  of.puts ("  " * indent) + "%label"; indent +=1
  of.puts ("  " * indent) + "#{question}"
  of.puts ("  " * indent) + ".hide.answer #{answers[qnumber]}"
  of.puts ("  " * indent) + "%ol{:type=>'a'}"; indent+=1
  of.puts ("  " * indent) + ".answers"; indent+=1
  return indent
end

def outAnswer answer, qnumber, of, indent
  qlabel = "q#{qnumber}"
  alabel = "#{qlabel}#{/^[A-Za-z]*/.match answer}"
  of.puts ("  " * indent) + "%li\n"; indent+=1
  of.puts ("  " * indent) + "%input{:type=>'radio', :name=>'#{qlabel}', :id=>'#{alabel}'}"
  of.puts ("  " * indent) + "%label{:for=>'#{alabel}'}"; indent += 1
  of.puts ("  " * indent) + answer.split(') ', 2)[1]; indent -= 2
  return indent
end

def parseQuiz quizfile
  indent = 0
  answers=Hash.new()
  qnumber = ""
  outfile = File.basename(quizfile, ".*") + ".html.haml"

  if File.exist? outfile
    of = File.open outfile, 'w'
  else
    of = File.new outfile, 'w'
  end
  indent = preamble of, indent

  file = File.open(quizfile, 'r').each_line do |line|
    p line + "\n"
    if (line.slice 0,9) == "ANSWERS: "
      line[9..-1].split("; ").each do | entry |
        q, a = entry.split(":")
        answers[q] = a.downcase
      end
    elsif (/^[0-9]/ === line )
      p "Question #{line}\n"
      # numeric initial value
      qnumber = /^[0-9]*/.match(line).to_s
      if Integer(qnumber) > 1
        indent -= 4
      end
      indent = outQuestion line, qnumber, answers, of, indent
    elsif (/^[a-zA-Z]/ === line)
      p "Answer #{line}\n"
      indent = outAnswer line, qnumber, of, indent
    end
  end
end

def mainloop
  if ARGV.length == 0
    File.exist?("quiz.txt") ? parseQuiz("quiz.txt") : usage
  else
    ARGV.each do |arg|
      File.exist?(arg) ? parseQuiz(arg) : usage
    end
  end
end

if $0 == __FILE__
  mainloop
  exit 0
end
