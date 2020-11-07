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
/^#/ {
  print "###" $0
  next
}
{
  print $0
}
