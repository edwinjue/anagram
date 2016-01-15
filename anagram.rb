#!/usr/bin/env ruby

unless ARGV.length == 1
  puts "Dude, not the right number of arguments."
  puts "Usage: ruby #{__FILE__} word\n"
  exit
end


def get_word_signature(word)
  word.each_char.sort.join
end

def words
  File.read('/usr/share/dict/words').split("\n")
end

def anagram(word)
  anagrams = []
  
  word_signature = get_word_signature(word)

  sub_word_signatures = generate_substrings(word_signature)

  lookup_hash = words.group_by{|w| w.each_char.sort.join } 
 
  sub_word_signatures.each{ |signature|
    anagrams << lookup_hash[signature] if lookup_hash[signature]
  }

  anagrams.flatten.uniq!
end

def generate_substrings(word)
  substrings = []
  word.chars.each_with_index{ |char,index|
    index.times { |i|
      substrings << word.chars.slice(0,index+1).permutation(i+1).to_a.map!{|a| a.join}
    }
  }

  substrings.flatten!
end

#p generate_substrings("thissucks")

results = anagram(ARGV[0])
p results
