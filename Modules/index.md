---
layout: packageModules
---

# GAP Package {{site.data.packageModules.name}}

{{site.data.packageModules.abstract}}

The current version of this package is version {{site.data.packageModules.version}}.
For more information, please refer to [the package manual]({{site.data.packageModules.doc-html}}).
There is also a [README](README) file.

## Dependencies

This package requires GAP version {{site.data.packageModules.GAP}}
{% if site.data.packageModules.needed-pkgs %}
The following other GAP packages are needed:
{% for pkg in site.data.packageModules.needed-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}
{% if site.data.packageModules.suggested-pkgs %}
The following additional GAP packages are not required, but suggested:
{% for pkg in site.data.packageModules.suggested-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}


## Author{% if site.data.packageModules.authors.size != 1 %}s{% endif %}
{% for person in site.data.packageModules.authors %}
{% if person.url %}<a href="{{ person.url }}">{{ person.name }}</a>{% else %}{{ person.name }}{% endif %}{% unless forloop.last %}, {% endunless %}{% else %}
{% endfor %}

{% if site.github.issues_url %}
## Feedback

For bug reports, feature requests and suggestions, please use the
[issue tracker]({{site.github.issues_url}}).
{% endif %}
