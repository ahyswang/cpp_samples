#
# global config options
#

# ----------------------------------------------------------------------------
# config options
# ----------------------------------------------------------------------------

# JPEG
__CONFIG_JPEG ?= n


# ----------------------------------------------------------------------------
# config symbols
# ----------------------------------------------------------------------------

ifeq ($(__CONFIG_XPLAYER), y)
  CONFIG_SYMBOLS += -D__CONFIG_XPLAYER
endif