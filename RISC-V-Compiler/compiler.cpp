#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>
#include <unordered_map>
#include <algorithm>
#include <cctype>
#include <bitset>

#include "compiler.hpp"

using namespace std;

string convertToBinary(int num, int bitSize = 12)
{
    string binary = bitset<32>(num).to_string(); // Convert to binary
    return binary.substr(binary.size() - bitSize); // Return the last bitSize bits
}

bool trim(string& str)
{
    size_t comment = str.find('#');

    if (comment != string::npos) str = str.substr(0, comment);

    if (str.empty() || str.find_first_not_of("\t\n\r") == string::npos) return true;

    size_t first = str.find_first_not_of(' ');

    if (string::npos == first) return false;

    size_t last = str.find_last_not_of(' ');

    str = str.substr(first, (last - first + 1));

    return false;
}

bool isWanted(char c){

    char C = tolower(c);
    bool check = (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9');

    return check;
}

string cleanToken(string token){

    string new_token = "";

    for (int i = 0; i < token.length(); i++){
        if (isWanted(token[i])) new_token += token[i];
        else continue;
    }

    return new_token;
}

vector<string> parse(string line)
{
    istringstream s(line);
    vector<string> tokens;
    string token;

    while(getline(s, token, ','))
    {
        tokens.push_back(token);
    }

    istringstream ss(tokens[0]);
    vector<string> subtokens;

    while(getline(ss, token, ' '))
    {
        subtokens.push_back(token);
    }

    tokens.erase(tokens.begin());

    tokens.insert(tokens.begin(), subtokens.begin(), subtokens.end());

    for(int i = 0; i < tokens.size(); i++)
    {
        tokens[i] = cleanToken(tokens[i]);
    }

    vector<string> finalTokens;

    for(int i = 0; i < tokens.size(); i++){
        if(tokens[i] != " " && !tokens[i].empty()) finalTokens.push_back(tokens[i]);
        else continue;
    }

    return finalTokens;
}

string compileLine(vector<string> tokens)
{
    string machineCode = "";

    // First token is the operation
    string instruction = tokens[0];
    machineCode += opcode[instruction];

    // Check the instruction (R-type)
    if (instruction == "add" || instruction == "sub" || 
        instruction == "sll" || instruction == "slt" || 
        instruction == "sltu" || instruction == "xor" || 
        instruction == "srl" || instruction == "sra" || 
        instruction == "or" || instruction == "and"){

        // Second token is the destination register
        machineCode.insert(0, registers[tokens[1]]);

        // Translate the instruction to funct3
        machineCode.insert(0, funct3[instruction]);

        // Third and fourth tokens are source registers
        machineCode.insert(0, registers[tokens[2]]);

        machineCode.insert(0, registers[tokens[3]]);

        // Translate the instruction to funct7
        machineCode.insert(0, funct7[instruction]);
    }

    // Check the instruction (I-type)
    if (instruction == "addi" || instruction == "andi" || 
        instruction == "slli" || instruction == "slti" || 
        instruction == "sltiu" || instruction == "xori" || 
        instruction == "srli" || instruction == "srai" || 
        instruction == "ori"){

        // Second token is the destination register
        machineCode.insert(0, registers[tokens[1]]);

        // Translate the instruction to funct3
        machineCode.insert(0, funct3[instruction]);

        // Third token is the source register
        machineCode.insert(0, registers[tokens[2]]);

        // Fourth token is the immediate value
        machineCode.insert(0, convertToBinary(stoi(tokens[3])));
    }

    return machineCode;
}

int main()
{
    ifstream in("assembly_code.txt");
    ofstream out("machine_code.txt");

    if (!in.is_open()) {
        cerr << "Error: File not found" << endl;
        return 1;
    }

    if (!out.is_open()) {
        cerr << "Unable to write to file" << endl;
        return 1;
    }

    string line;

    while (getline(in, line)){

        if(trim(line)) continue;

        auto tokens = parse(line);
        
        auto machineCode = compileLine(tokens);

        out << machineCode << endl;
    }

    in.close();
    out.close();

    return 0;
}