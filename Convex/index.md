---
layout: packageConvex
---

# GAP Package {{site.data.packageConvex.name}}

{{site.data.packageConvex.abstract}}

The current version of this package is version {{site.data.packageConvex.version}}.
For more information, please refer to [the package manual]({{site.data.packageConvex.doc-html}}).
There is also a [README](README) file.

## Dependencies

This package requires GAP version {{site.data.packageConvex.GAP}}
{% if site.data.packageConvex.needed-pkgs %}
The following other GAP packages are needed:
{% for pkg in site.data.packageConvex.needed-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}
{% if site.data.packageConvex.suggested-pkgs %}
The following additional GAP packages are not required, but suggested:
{% for pkg in site.data.packageConvex.suggested-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}


## Author{% if site.data.packageConvex.authors.size != 1 %}s{% endif %}
{% for person in site.data.packageConvex.authors %}
{% if person.url %}<a href="{{ person.url }}">{{ person.name }}</a>{% else %}{{ person.name }}{% endif %}{% unless forloop.last %}, {% endunless %}{% else %}
{% endfor %}

{% if site.github.issues_url %}
## Feedback

For bug reports, feature requests and suggestions, please use the
[issue tracker]({{site.github.issues_url}}).
{% endif %}
