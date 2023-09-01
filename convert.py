import xml.etree.ElementTree as ET

def clean_text_element(text_element):
    text_element.tag = "text"
    text_element.attrib.clear()

def extract_title_text(input_path, output_path):
    tree = ET.parse(input_path)
    root = tree.getroot()

    output_root = ET.Element("xml")

    for page in root.findall("./page"):
        title_element = page.find("title")
        text_element = page.find("revision/text")

        if title_element is not None and text_element is not None:
            clean_text_element(text_element)

            output_page = ET.SubElement(output_root, "page")
            titlexml=ET.SubElement(output_page,"title")
            titlexml.text=title_element.text
            textxml=ET.SubElement(output_page,"text")
            textxml.text=text_element.text

    output_tree = ET.ElementTree(output_root)
    output_tree.write(output_path)

if __name__ == "__main__":
    input_path = "/home/adarsh/Desktop/NLP-ENGLISH-DICTIONARY/test.xml"
    output_path = "ans.xml"
    extract_title_text(input_path, output_path)
