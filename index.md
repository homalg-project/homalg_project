---
layout: default
---

# The homalg project

This is the home of the homalg project. For more information, please see the packages listed below.

Please note that packages distributed with [GAP](http://www.gap-system.org) might be slightly older.

## Packages in the homalg project



{% for package in site.data.packages.package_links %}
  [{{package.name}}]({{site.baseurl}}/{{package.name}})
{% endfor %}


## Dependencies

This project requires GAP version {{site.data.packagehomalg.GAP}}
For more information see the packages


## Author{% if site.data.frontpage.authors.size != 1 %}s{% endif %}
{% for person in site.data.frontpage.authors %}
{% if person.url %}<a href="{{ person.url }}">{{ person.name }}</a>{% else %}{{ person.name }}{% endif %}{% unless forloop.last %}, {% endunless %}{% else %}
{% endfor %}

{% if site.github.issues_url %}
## Feedback

For bug reports, feature requests and suggestions, please use the
[issue tracker]({{site.github.issues_url}}).
{% endif %}
