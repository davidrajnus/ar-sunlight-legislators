require_relative 'models/legislator'

p "Choose a state: (which is the two letter initial)"
state = gets.chomp

p "Senators:"
sens = Legislator.where(state: state).order(lastname: :desc)
sens.each do |sen|
  p "  #{sen.firstname} (#{sen.party})"
end

p "Representatives:"
reps = Legislator.where(state: state).order(lastname: :desc)
reps.each do |rep|
  p "  #{rep.firstname} (#{rep.party})"
end

p "Choose a gender: (M of F)"
gender = gets.chomp

number_sen = Legislator.where(gender: gender,title: "Sen", in_office: TRUE).count
total_sen = Legislator.where(title: "Sen", in_office: TRUE).count
number_rep = Legislator.where(gender: gender,title: "Rep", in_office: TRUE).count
total_rep = Legislator.where(title: "Rep", in_office: TRUE).count

if gender == "M"
	puts "Male Senators: #{number_sen} (#{number_sen/total_sen*100}%)"
	puts "Male Representatives: #{number_rep} (#{number_sen/total_rep*100}%)"
else
	puts "Female Senators: #{number_sen} (#{number_sen/total_sen*100}%)"
	puts "Female Representatives: #{number_rep} (#{number_sen/total_rep*100}%)"
end


state_reps = Legislator.where(in_office: true, title: "Rep").group(:state).count
state_reps = state_reps.sort_by {|k,v| v}.reverse
 
state_reps.each do |state|
 puts "#{state[0]}: 2 Senators, #{state[1]} Representatives"
 end

sen = Legislator.where(title: "Sen").count
rep = Legislator.where(title: "Rep").count

puts "Senators: #{sen}"
puts "Representatives: #{rep}"

Legislator.where(in_office: false).delete_all
puts

sen = Legislator.where(title: "Sen").count
rep = Legislator.where(title: "Rep").count

puts "Senators: #{sen}"
puts "Representatives: #{rep}"