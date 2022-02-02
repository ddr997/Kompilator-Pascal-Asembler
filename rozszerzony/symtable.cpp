#include "global.h"

Symtable::Symtable(){} 

int Symtable::insert_to_table(string s, InputType input_type, VarType vartype)
{   
    Record new_record;
    switch(input_type)
    {
    case InputType::IDENTIFIER:
        new_record.name = s;
        new_record.vartype = vartype;
        new_record.input_type = input_type;
        table.push_back(new_record);
        return table.size() - 1;
        break;

    case InputType::NUMBER:
        new_record.name = s;
        new_record.value = stoi(s);
        new_record.vartype = vartype;
        new_record.input_type = input_type;
        table.push_back(new_record);
        return table.size() - 1;
        break;

    case InputType::TEMPORARY:
        new_record.name = s + to_string(next_temp);
        next_temp += 1;
        new_record.vartype = vartype;
        new_record.input_type = input_type;
        new_record.address = next_address;
        if(vartype == VarType::INTEGER){ new_record.vartype = VarType::INTEGER; next_address += 4; }
        if(vartype == VarType::REAL){ new_record.vartype = VarType::REAL; next_address += 8; }
        table.push_back(new_record);
        return table.size() - 1;
        break;
    
    case InputType::TEMPORARY_LOCAL:
        new_record.name = s + to_string(next_temp);
        next_temp += 1;
        new_record.vartype = vartype;
        new_record.input_type = input_type;
        if(vartype == VarType::INTEGER){ new_record.vartype = VarType::INTEGER; next_local_address -= 4; }
        if(vartype == VarType::REAL){ new_record.vartype = VarType::REAL; next_local_address -= 8; }
        new_record.address = next_local_address;
        table.push_back(new_record);
        return table.size()-1;
        break;

    }
    return -1;
}

int Symtable::find_in_table(string s)
{
    for(int i=0; i< (int) table.size(); i++)
    {
        if(table.at(i).name == s)
        {
            return i;
        }
    }
    return -1;
}

void Symtable::print_table()
{
    string column_names[6] = {"Name", "InpTyp", "VarTyp", "Scope", "Value", "Address"};
    for(int i=0; i<6; i++){
        cout << "|" << column_names[i] << "\t\t";
    }
    cout << "\n" + string(90,'-') << endl;
    for(int i=0; i < (int)table.size(); i++)
    {
        cout << "|" << table[i].name << "\t\t|" << static_cast<int>(table[i].input_type) << "\t\t|" << static_cast<int>(table[i].vartype) << "\t\t|"
        << static_cast<int>(table[i].scope) <<"\t\t|" << table[i].value << "\t\t|" 
        << table[i].address << endl;
    }
}