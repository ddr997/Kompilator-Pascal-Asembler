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
        new_record.scope = Scope::LOCAL;
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

void Symtable::refresh_symtable()
{
    for(int i = 0; i < global_variables_memory.size(); i++)
    {
        for(int j = 0; j < table.size(); j++)
        {
        if(global_variables_memory[i].name == table[j].name)
            table[j] = global_variables_memory[i];
        }
    }
    table.erase(std::remove_if( table.begin(), table.end(),[](Record const& v) { return v.scope == Scope::LOCAL; }), table.end());

    // //czyszczenie pamieci zmiennych lokalnych do zmiennych globalnych (w przypadku gdy uzyto np. x lokalnego i globalnego)
    // for(int i = 0; i < SYMTABLE.global_variables_memory.size(); i++)
    // {
    //     for(int j = 0; j < SYMTABLE.table.size(); j++)
    //     {
    //     if(SYMTABLE.global_variables_memory[i].name == SYMTABLE.table[j].name)
    //         SYMTABLE.table[j] = SYMTABLE.global_variables_memory[i];
    //     }
    // }

    // //czysc tablice ze zmiennych tymczasowych
    // SYMTABLE.table.erase(std::remove_if( SYMTABLE.table.begin(), SYMTABLE.table.end(),[](Record const& v) { return v.scope == Scope::LOCAL; }),SYMTABLE.table.end());
    
}

void Symtable::print_table()
{
    string column_names[6] = {"Name", "InpTyp", "VarTyp", "Scope", "Address"};
    for(int i=0; i<5; i++){
        cout << "|" << column_names[i] << "\t\t";
    }
    cout << "\n" + string(70,'-') << endl;
    
    string nametab = "";
    for(int i=0; i < (int)table.size(); i++)
    {
        if(table[i].name.length() >= 7)
            nametab = "\t|";
        else
            nametab = "\t\t|";
        cout << "|" << table[i].name << nametab << static_cast<int>(table[i].input_type) << "\t\t|" << static_cast<int>(table[i].vartype) << "\t\t|"
        << static_cast<int>(table[i].scope) <<"\t\t|" << table[i].address << endl;
    }
    cout << "" << endl;
    // Table t;
    // t.add_row({"Name", "InputType", "VarType", "Scope", "Address"});
    // t.format().font_align(FontAlign::center);
    // for(int i=0; i < table.size(); i++)
    // {
    //     t.add_row({table[i].name, to_string(static_cast<int>(table[i].input_type)), to_string(static_cast<int>(table[i].vartype)),
    //     to_string(static_cast<int>(table[i].scope)), to_string(table[i].address)});
    // }
    // for (auto& cell : t.column(4)) 
    // {
    // cell.format().font_color(Color::yellow);
    // }
    // for (auto& cell : t.column(0)) 
    // {
    // cell.format().font_color(Color::green);
    // }
    // cout << t << endl;
}