import urllib
from FactorySystem import MooseObject

##
# Base class for markdown image maniuplation
class ImageBase(MooseObject):

  @staticmethod
  def validParams():
    params = MooseObject.validParams()
    params.addParam('caption', 'The image caption')
    params.addParam('show_caption', True, 'Toggle the visibility of the caption')
    params.addParam('name', 'The image file name')
    params.addParam('url', 'The image file url')
    params.addParam('download', 'Download the image locally')

    params.addParam('align', 'The image horizontal alignment')
    params.addParam('width', 'The image width')
    params.addParam('height', 'The image height')
    params.addParam('style', 'The img style property')
    params.addParam('vertical-align', 'The vertical alignment of the image')
    params.addParamsToGroup('html', ['align', 'width', 'height', 'vertical-align', 'style'])

    return params

  @staticmethod
  def extractName(match):
    return None

  ##
  # Constructor
  def __init__(self, name, params):
    MooseObject.__init__(self, name, params)
    self.parent = self.getParam('_parent')
    self.match = self.getParam('_match')

    # Store the complete markdown image text
    self._raw = self.match.group(0)

    # Set download flag (default is true)
    self._download = True
    if self.isParamValid('download'):
      d = self._pars['download']
      if d.lower() == 'false' or d == 0:
        self._download = False


  ##
  # Perform the matching
  # @param markdown The raw markdown to parse
  # @return A list of match iterators (i.e., re.finditer)
  @staticmethod
  def match(markdown):
    return []

  ##
  # Return the regex for performing image substitution (virtual)
  def sub(self):
    return ''

  ##
  # Return the image html for replacing the markdown image syntax
  def html(self):

    # Get the name and url
    name = self.getParam('name')
    url = self.getParam('url')

    # Do not download the image
    if self._download:
      urllib.urlretrieve(url, name)
      img_name = name
    else:
      img_name = url


    # Create the html <img> block
    img = '<figure style="float:left">\n'
    img += '  <a href="' + url + '">\n'
    img += '    <img src="' + img_name + '"'

    for prop in self._pars.groupKeys('html'):
      if self.isParamValid(prop):
        img += ' ' + prop + '="' + self._pars[prop] + '"'
    img += '/>\n  </a>\n'

    # Create a table that contains the image and caption (if desired)
    if self._pars['show_caption'] and self.isParamValid('caption'):
      img += '  <figcaption>\n'
      img += '    ' + self._pars['caption']
      img += '\n  </figcaption>\n'

    img += '</figure>\n'

    # Return the complete html
    return img
