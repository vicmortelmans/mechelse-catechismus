#!/bin/awk -f
#
# Merge multiple Markdown files into one. Each source file has frontmatter fields
# for 'part', 'title' and 'subtitle', which are turned into headings.
# Headings in the content are therefore demoted by 3 steps.
#
BEGIN {
  frontmatter = 0
}
/^---/ {
  frontmatter = !frontmatter
  if (!frontmatter) {
    print "\n"
    if (part) print "# " part "\n"
    if (title) print "## " title "\n"
    if (subtitle) print "### " subtitle "\n"
  }
  next
}
/^part:/ {
  if (match($0,": ")) {
    newpart = substr($0,RSTART+RLENGTH)
    gsub(/^[ \t]+|[ \t]+$/, "", newpart)
    if (newpart != oldpart) {
      part = newpart
      oldpart = newpart
    } else {
      part = ""
    }
  }
  next
}
/^title:/ {
  if (match($0,": ")) {
    title = substr($0,RSTART+RLENGTH)
  }
  next
}
/^subtitle:/ {
  if (match($0,": ")) {
    subtitle = substr($0,RSTART+RLENGTH)
  }
  next
}
/^# / {
  question = $0  # store it for later
  next
}
/^## / {
  answer = $0  # store it for later
  next
}
/^### / {
  print "###" $0
  next
}
/^\s*$/ {
  # reproduce blank lines
  print $0
  next
}
{
  # first check if question/answer is in store
  if (question || answer) {
    print "<div class=pagebreakcontrol>"
    if (question) print "###" question
    if (answer) print "###" answer
    print "</div>"
    question = ""
    answer = ""
  }
  print $0
  next
}
