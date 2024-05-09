#pragma once

#include <common.hpp>

#include <unordered_map>

template<typename T>
class Trackable
{
public:
    Trackable()
    {
        ID = NextID++;
        Instances[ID] = this;
    }

    virtual ~Trackable()
    {
        Instances.erase(ID);
    }

    static bool Exists(size_t id)
    {
        return (Instances.find(id) != Instances.end());
    }

    static T* Get(size_t id)
    {
        return dynamic_cast<T*>(Instances.at(id));
    }

    size_t GetID() const { return ID; }

private:
    static inline size_t NextID = 0;

    static inline std::unordered_map<size_t, Trackable<T>*> Instances;

    size_t ID;
};
