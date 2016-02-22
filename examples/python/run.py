import sys

sys.path.append("./../../python")
from bitbucket_rest_api import BitbucketRestUtils

bitbucket_utils = BitbucketRestUtils()
values = bitbucket_utils.get_list_of_commits("user@onbitbucket.com", "strongpassword", "meyteam", "uirepo",
                                             branch_or_tag="master", exclude="tag.2016.02.11.0")
