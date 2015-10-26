---
layout: packageGaussForHomalg
---

# GAP Package {{site.data.packageGaussForHomalg.name}}

{{site.data.packageGaussForHomalg.abstract}}

The current version of this package is version {{site.data.packageGaussForHomalg.version}}.
For more information, please refer to [the package manual]({{site.data.packageGaussForHomalg.doc-html}}).
There is also a [README](README) file.

## Dependencies

This package requires GAP version {{site.data.packageGaussForHomalg.GAP}}
{% if site.data.packageGaussForHomalg.needed-pkgs %}
The following other GAP packages are needed:
{% for pkg in site.data.packageGaussForHomalg.needed-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}
{% if site.data.packageGaussForHomalg.suggested-pkgs %}
The following additional GAP packages are not required, but suggested:
{% for pkg in site.data.packageGaussForHomalg.suggested-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}


## Author{% if site.data.packageGaussForHomalg.authors.size != 1 %}s{% endif %}
{% for person in site.data.packageGaussForHomalg.authors %}
{% if person.url %}<a href="{{ person.url }}">{{ person.name }}</a>{% else %}{{ person.name }}{% endif %}{% unless forloop.last %}, {% endunless %}{% else %}
{% endfor %}

{% if site.github.issues_url %}
## Feedback

For bug reports, feature requests and suggestions, please use the
[issue tracker]({{site.github.issues_url}}).
{% endif %}
