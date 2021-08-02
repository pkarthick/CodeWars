import unittest
import re

def domain_name(url):
    url = url.split("://")[-1]
    xs = url.split(".")
    return xs[0] if xs[0] != "www" else xs[1]

class TestStringMethods(unittest.TestCase):

    def test(self):
            
        self.assertEqual(domain_name("http://google.com"), "google")
        self.assertEqual(domain_name("http://google.co.jp"), "google")
        self.assertEqual(domain_name("www.xakep.ru"), "xakep")
        self.assertEqual(domain_name("https://youtube.com"), "youtube")
        self.assertEqual(domain_name("http://github.com/carbonfive/raygun"), "github")
        self.assertEqual(domain_name("http://www.zombie-bites.com"), "zombie-bites")
        self.assertEqual(domain_name("https://www.cnet.com"), "cnet")

if __name__ == '__main__':
    unittest.main()
