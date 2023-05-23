//
//  DataBaseManeger.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 22/05/2023.
//
import CoreData
import UIKit

class DataBaseManeger : DatabaseServiceProtocol{
    private static var sharedInstance = DataBaseManeger()
    private var appDelegate : AppDelegate!
    private var context : NSManagedObjectContext!
    private var entity : NSEntityDescription!
    private var team : NSManagedObject!
    private var teamsArrayNS = [NSManagedObject]()
        private init() {
            appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            context = appDelegate.persistentContainer.viewContext
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
    
    static func shared() -> DataBaseManeger {
        return sharedInstance
    }
    
    func saveData(teamData : Teams) {
        entity = NSEntityDescription.entity(forEntityName: K.ENTITY_NAME, in: context)
        team = NSManagedObject(entity: entity!, insertInto: context)
        team.setValue(teamData.team_logo, forKey: "teamLogo")
        team.setValue(teamData.team_name, forKey: "teamName")
        team.setValue(Int32(teamData.team_key!), forKey: "teamId")
        do {
            try context.save()
            
            print("Team added")
 
        }catch{
            print("error")
        }

    }
    func getData() -> [Teams] {
        var teamsList = [Teams]()
        print("Team get")
        let req = NSFetchRequest<NSManagedObject>(entityName: K.ENTITY_NAME)
        do {
            teamsArrayNS = try context.fetch(req)
            for team in teamsArrayNS {
                let name = team.value(forKey: "teamName") as? String
                let logo = team.value(forKey: "teamLogo") as? String
                let id = team.value(forKey: "teamId") as? Int
                let t = Teams()
                t.team_name = name
                t.team_logo = logo
                t.team_key = id
                teamsList.append(t)
            }
        } catch {
            print("ERROR")
        }
        return teamsList
    }
    
    func deleteData(teamId:Int){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.ENTITY_NAME)
        fetchRequest.predicate = NSPredicate(format: "teamId == %@", argumentArray: [teamId])
     
        do {
            let results = try context.fetch(fetchRequest)
            if let team = results.first as? NSManagedObject {
                context.delete(team)
                try context.save()
                print("Team deleted")
            }
        }catch{
            print("error")
        }
    }
    
    func isFav(teamId: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.ENTITY_NAME)
        fetchRequest.predicate = NSPredicate(format: "teamId == %@", argumentArray: [teamId])
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty // Return true if the team with the given ID exists, indicating it is a favorite
        } catch {
            print("Error checking favorite status: \(error)")
            return false
        }
    }
    
    

}
