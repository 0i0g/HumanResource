using Application.Interfaces;
using Application.ViewModels;
using Firebase.Database;
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using Utilities.Helper;

namespace Application.Implementations
{
    public class FirebaseService : IFirebaseService
    {
        private FirebaseClient client;

        public FirebaseService()
        {
            var db = ConfigurationHelper.Configuration.GetSection("Firebase:Database").Value;
            var secret = ConfigurationHelper.Configuration.GetSection("Firebase:Secret").Value;
            client = new FirebaseClient(db, new FirebaseOptions { AuthTokenAsyncFactory = () => Task.FromResult(secret) });
        }

        public async Task Test()
        {
            await client.Child("Test").PostAsync(JsonSerializer.Serialize(new UserProfile { Email = "hoang" }));
        }
    }
}
