
try:
    from setuptools import setup
except ImportError:
    print "Falling back to distutils. Functionality may be limited."
    from distutils.core import setup

config = {
    'description'  : 'DESCRIPTION GOES HERE',
    'author'       : 'Brandon Sandrowicz',
    'url'          : 'http://github.com/bsandrow/PROJECT NAME GOES HERE',
    'author_email' : 'brandon@sandrowicz.org',
    'version'      : 'VERSION GOES HERE'.
    'packages'     : [],
    'name'         : 'NAME GOES HERE',
    'test_suite'   : 'TESTS GO HERE',
}

setup(**config)
