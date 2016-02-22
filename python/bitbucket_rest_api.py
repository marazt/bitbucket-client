import requests


class BitbucketRestUtils(object):
    """
    Class for bitbucket utils calls
    """
    bitbucket_url = "https://api.bitbucket.org/2.0"

    def _call_resource(self, url, method, auth):
        """
        Method to call API resource

        :param url: resource url
        :param method: http method
        :param auth: authentication par (username, password)
        :return: json response
        """
        print "Calling resource '{0}'".format(url)
        response = requests.request(method, url, auth=auth)
        return response.json()

    def get_list_of_commits(self, username, password, team, repository, branch_or_tag="", include="", exclude=""):
        """
        Method to get list of commits in team repository

        :param username: user name
        :param password: user password
        :param team: team name
        :param repository: repository name
        :param branch_or_tag: branch, tag or hash, optional
        :param include: branch or tag to be included
        :param exclude: branch or tag to be excluded
        :return: list of commits
        """

        arguments = ""
        arguments_set = False

        for key, value in {"include": include, "exclude": exclude}.iteritems():
            if value is not None and value != "":
                arguments = "{0}{1}{2}={3}".format(arguments, "&" if arguments_set else "", key, value)
                arguments_set = True

        url = "{0}/repositories/{1}/{2}/commits/{3}{4}{5}".format(self.bitbucket_url, team, repository, branch_or_tag,
                                                                  "?" if arguments_set else "", arguments)
        auth = (username, password)
        method = "get"

        data = self._call_resource(url, method, auth)
        result = data["values"]
        while "next" in data:
            data = self._call_resource(data["next"], method, auth)
            result = result + data["values"]

        return result