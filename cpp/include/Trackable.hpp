#pragma once

#include <common.hpp>

#include <unordered_map>

class Trackable
{
public:
    virtual ~Trackable()
    {
        Instances.erase(ID);
    }

    template<typename T>
    static bool Exists(size_t id)
    {
        auto it = Instances.find(id);
        return (it != Instances.end() && dynamic_cast<T*>(it->second) != nullptr);
    }

    template<typename T>
    static T* Get(size_t id)
    {
        return dynamic_cast<T*>(Instances.at(id));
    }

    size_t GetID() const { return ID; }

protected:
    Trackable()
    {
        ID = NextID++;
        Instances[ID] = this;
    }

private:
    static inline size_t NextID = 0;
    static inline std::unordered_map<size_t, Trackable*> Instances{};
    size_t ID;
};
